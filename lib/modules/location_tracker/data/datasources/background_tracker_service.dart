import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:location_tracker/core/services/db_helper.dart';
import 'package:location_tracker/modules/location_tracker/data/datasources/location_service.dart';
import 'package:location_tracker/modules/location_tracker/data/models/location_model.dart';

class BackgroundTrackerService {
  static const String notificationChannelId = 'location_tracker_channel';
  static const int notificationId = 888;

  /// Initializes the background service configuration.
  static Future<void> initialize() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: notificationChannelId,
        foregroundServiceNotificationId: notificationId,
        initialNotificationTitle: 'Location Tracking',
        initialNotificationContent: 'Preparing to track...',
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  /// Starts the location tracking background process.
  static Future<void> start(String sessionId) async {
    await setActiveSessionId(sessionId);
    final service = FlutterBackgroundService();
    final isRunning = await service.isRunning();

    if (!isRunning) {
      await service.startService();
    }

    // Give it a brief moment to start up and set up listener, then send session details
    Future.delayed(const Duration(milliseconds: 500), () {
      service.invoke('set_session', {'sessionId': sessionId});
    });
  }

  /// Stops the background tracking process.
  static Future<void> stop() async {
    await setActiveSessionId(null);
    final service = FlutterBackgroundService();
    service.invoke('stop_service');
  }

  /// Check if background service is running.
  static Future<bool> isTracking() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/tracking_status.txt');
      if (await file.exists()) {
        final content = await file.readAsString();
        return content.trim() == 'true';
      }
    } catch (_) {}
    return false;
  }

  /// Set tracking state in local file.
  static Future<void> setTrackingState(bool isTracking) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/tracking_status.txt');
      await file.writeAsString(isTracking ? 'true' : 'false');
    } catch (_) {}
  }

  /// Get active session ID from local file.
  static Future<String?> getActiveSessionId() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/active_session_id.txt');
      if (await file.exists()) {
        final content = await file.readAsString();
        return content.trim().isEmpty ? null : content.trim();
      }
    } catch (_) {}
    return null;
  }

  /// Set active session ID in local file.
  static Future<void> setActiveSessionId(String? sessionId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/active_session_id.txt');
      if (sessionId == null) {
        if (await file.exists()) {
          await file.delete();
        }
      } else {
        await file.writeAsString(sessionId);
      }
    } catch (_) {}
  }
}

// iOS Background entry point
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

// Global Background Entry Point
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Ensure Flutter engine context is ready
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final dbHelper = DBHelper();
  final locationService = LocationService();
  String currentSessionId = 'active_session';
  Timer? trackingTimer;

  // Set up notification updates for Android
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  // Define location tracking task logic
  void performLocationTrackingTask() async {
    final result = await locationService.getCurrentLocation();

    await result.fold(
      (failure) async {
        // Log failure or send to main app
        service.invoke('tracking_error', {'message': failure.toString()});
      },
      (position) async {
        final timestampString = DateTime.now().toIso8601String();
        final locationModel = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: timestampString,
          accuracy: position.accuracy,
          sessionId: currentSessionId,
        );

        // Save location locally using SQLite
        await dbHelper.insertLocation(locationModel);

        // Update foreground notification on Android with pretty timestamp
        if (service is AndroidServiceInstance) {
          final timeFormatted = DateFormat('hh:mm:ss a').format(DateTime.now());
          service.setForegroundNotificationInfo(
            title: "Location Tracking Active",
            content:
                "Last saved: $timeFormatted (${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)})",
          );
        }

        // Notify main app UI if active
        service.invoke('location_updated', locationModel.toJson());
      },
    );
  }

  // Check if we should auto-resume tracking (e.g. after a force-kill / OS restart)
  final isTracking = await BackgroundTrackerService.isTracking();
  final savedSessionId = await BackgroundTrackerService.getActiveSessionId();

  if (isTracking && savedSessionId != null) {
    currentSessionId = savedSessionId;
    // Perform initial capture immediately
    performLocationTrackingTask();

    // Start 60-second periodic tracker
    trackingTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      performLocationTrackingTask();
    });
  }

  // Listeners for events from Main Isolate
  service.on('set_session').listen((event) {
    if (event != null && event.containsKey('sessionId')) {
      currentSessionId = event['sessionId'];

      // Perform initial capture immediately
      performLocationTrackingTask();

      // Cancel existing timers if any
      trackingTimer?.cancel();

      // Start 60-second periodic tracker
      trackingTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
        performLocationTrackingTask();
      });
    }
  });

  service.on('stop_service').listen((event) {
    trackingTimer?.cancel();
    service.stopSelf();
  });
}
