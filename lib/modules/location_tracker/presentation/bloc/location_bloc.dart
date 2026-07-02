import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_tracker/core/error/failure.dart';
import 'package:location_tracker/core/services/battery_service.dart';
import 'package:location_tracker/core/services/db_helper.dart';
import 'package:location_tracker/modules/location_tracker/data/datasources/background_tracker_service.dart';
import 'package:location_tracker/modules/location_tracker/data/datasources/location_service.dart';
import 'package:location_tracker/modules/location_tracker/data/models/location_model.dart';
import 'package:location_tracker/modules/location_tracker/domain/entities/location_entity.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final DBHelper dbHelper;
  final BatteryService batteryService;
  final LocationService locationService;
  
  StreamSubscription? _locationSubscription;
  Timer? _batteryTimer;

  LocationBloc({
    required this.dbHelper,
    required this.batteryService,
    required this.locationService,
  }) : super(LocationState.initial()) {
    on<LocationEvent>((event, emit) async {
      await event.when(
        init: () async {
          // Check if service is already tracking from previous launch
          final isRunning = await BackgroundTrackerService.isTracking();
          
          // Poll battery level initially
          add(const LocationEvent.updateBattery());
          
          // Listen to background service updates
          await _locationSubscription?.cancel();
          _locationSubscription = FlutterBackgroundService().on('location_updated').listen((data) {
            if (data != null) {
              final model = LocationModel.fromJson(data);
              add(LocationEvent.onLocationCaptured(model));
            }
          });

          // Set up periodic 10-second battery updates (home screen dashboard)
          _batteryTimer?.cancel();
          _batteryTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
            add(const LocationEvent.updateBattery());
          });

          emit(state.copyWith(
            isTracking: isRunning,
          ));

          // Load historical sessions
          add(const LocationEvent.loadSessions());
        },
        startTracking: () async {
          emit(state.copyWith(startTrackingResult: none()));
          
          // 1. Verify permissions
          final permissionResult = await locationService.checkAndRequestPermissions();
          
          await permissionResult.fold(
            (failure) async {
              emit(state.copyWith(
                startTrackingResult: some(Left(failure)),
              ));
            },
            (_) async {
              // 2. Generate new unique session ID
              final sessionId = 'Session_${DateTime.now().millisecondsSinceEpoch}';
              
              // 3. Start background worker
              await BackgroundTrackerService.start(sessionId);
              await BackgroundTrackerService.setTrackingState(true);
              
              emit(state.copyWith(
                isTracking: true,
                selectedSessionId: sessionId,
                currentSessionLocations: const [],
                startTrackingResult: some(const Right(true)),
              ));

              // Reload sessions to list the new active session
              add(const LocationEvent.loadSessions());
            },
          );
        },
        stopTracking: () async {
          await BackgroundTrackerService.stop();
          await BackgroundTrackerService.setTrackingState(false);
          emit(state.copyWith(
            isTracking: false,
          ));
          add(const LocationEvent.loadSessions());
        },
        loadSessions: () async {
          emit(state.copyWith(isLoadingHistory: true));
          try {
            final sessionsList = await dbHelper.getSessionsList();
            
            // If there's an active session, auto-select it if nothing else is selected
            String? newSelectedSession = state.selectedSessionId;
            if (newSelectedSession == null && sessionsList.isNotEmpty) {
              newSelectedSession = sessionsList.first['session_id'];
            }

            emit(state.copyWith(
              sessions: sessionsList,
              selectedSessionId: newSelectedSession,
              isLoadingHistory: false,
            ));

            // Load coordinates for selected session if any
            if (newSelectedSession != null) {
              add(LocationEvent.selectSession(newSelectedSession));
            }
          } catch (e) {
            emit(state.copyWith(
              isLoadingHistory: false,
              loadLocationsResult: some(Left(Failure.databaseError(e.toString()))),
            ));
          }
        },
        selectSession: (sessionId) async {
          if (sessionId == null) {
            emit(state.copyWith(
              selectedSessionId: null,
              currentSessionLocations: const [],
            ));
            return;
          }

          try {
            final models = await dbHelper.getLocationsForSession(sessionId);
            final entities = models.map((m) => m.toEntity()).toList();
            
            emit(state.copyWith(
              selectedSessionId: sessionId,
              currentSessionLocations: entities,
              loadLocationsResult: some(Right(entities)),
            ));
          } catch (e) {
            emit(state.copyWith(
              loadLocationsResult: some(Left(Failure.databaseError(e.toString()))),
            ));
          }
        },
        updateBattery: () async {
          final result = await batteryService.getBatteryLevel();
          result.fold(
            (failure) {
              // Ignore failure or set to -1
              emit(state.copyWith(batteryLevel: -1));
            },
            (level) {
              emit(state.copyWith(batteryLevel: level));
            },
          );
        },
        onLocationCaptured: (location) async {
          // If the captured point belongs to the currently active/selected session, append it to UI
          if (location.sessionId == state.selectedSessionId) {
            final entity = location.toEntity();
            final updatedLocations = List<LocationEntity>.from(state.currentSessionLocations)
              ..add(entity);
            
            emit(state.copyWith(
              currentSessionLocations: updatedLocations,
            ));
          }
          
          // Re-load sessions to update point count list dynamically
          final sessionsList = await dbHelper.getSessionsList();
          emit(state.copyWith(
            sessions: sessionsList,
          ));
        },
        deleteSession: (sessionId) async {
          await dbHelper.deleteSession(sessionId);
          
          String? nextSelected = state.selectedSessionId;
          if (nextSelected == sessionId) {
            nextSelected = null;
          }
          
          emit(state.copyWith(
            selectedSessionId: nextSelected,
          ));
          
          add(const LocationEvent.loadSessions());
        },
      );
    });
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    _batteryTimer?.cancel();
    return super.close();
  }
}
