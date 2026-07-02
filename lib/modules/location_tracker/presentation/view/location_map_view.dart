import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_tracker/core/di/service_locator.dart';
import 'package:location_tracker/core/error/failure.dart';
import 'package:location_tracker/modules/location_tracker/data/datasources/location_service.dart';
import 'package:location_tracker/modules/location_tracker/domain/entities/location_entity.dart';

class LocationMapView extends StatefulWidget {
  final List<LocationEntity> locations;

  const LocationMapView({required this.locations, super.key});

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  final MapController _mapController = MapController();
  LatLng? _liveLocation;
  bool _isLoadingLiveLocation = false;

  void _recenterMap() {
    if (widget.locations.isNotEmpty) {
      final latest = widget.locations.last;
      _mapController.move(LatLng(latest.latitude, latest.longitude), 16.0);
    }
  }

  void _zoomIn() {
    final currentZoom = _mapController.camera.zoom;
    if (currentZoom < 18.0) {
      _mapController.move(_mapController.camera.center, currentZoom + 1.0);
    }
  }

  void _zoomOut() {
    final currentZoom = _mapController.camera.zoom;
    if (currentZoom > 3.0) {
      _mapController.move(_mapController.camera.center, currentZoom - 1.0);
    }
  }

  Future<void> _moveToLiveLocation() async {
    setState(() {
      _isLoadingLiveLocation = true;
    });

    final locationService = serviceLocator<LocationService>();
    final result = await locationService.getCurrentLocation();

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _isLoadingLiveLocation = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get live location: ${failure.message}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (position) {
        final liveLatLng = LatLng(position.latitude, position.longitude);
        setState(() {
          _liveLocation = liveLatLng;
          _isLoadingLiveLocation = false;
        });
        _mapController.move(liveLatLng, 16.0);
      },
    );
  }

  Widget _buildMapControlBtn({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  )
                : Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 22.0,
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng initialCenter = widget.locations.isNotEmpty
        ? LatLng(
            widget.locations.last.latitude,
            widget.locations.last.longitude,
          )
        : const LatLng(51.509865, -0.118092);

    final double initialZoom = widget.locations.isNotEmpty ? 16.0 : 12.0;

    final List<LatLng> points = widget.locations
        .map((loc) => LatLng(loc.latitude, loc.longitude))
        .toList();

    final List<Marker> markers = [];
    for (int i = 0; i < widget.locations.length; i++) {
      final loc = widget.locations[i];
      final isLatest = i == widget.locations.length - 1;

      markers.add(
        Marker(
          point: LatLng(loc.latitude, loc.longitude),
          width: isLatest ? 40.0 : 20.0,
          height: isLatest ? 40.0 : 20.0,
          child: isLatest
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.5),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
        ),
      );
    }

    if (_liveLocation != null) {
      markers.add(
        Marker(
          point: _liveLocation!,
          width: 40.0,
          height: 40.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.6, 1.6), duration: 1500.ms, curve: Curves.easeOut)
              .fade(begin: 1.0, end: 0.0, duration: 1500.ms, curve: Curves.easeOut),
              Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: initialZoom,
              maxZoom: 18.0,
              minZoom: 3.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.outfox.location_tracker',
                retinaMode: RetinaMode.isHighDensity(context),
              ),
              if (points.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      strokeWidth: 4.0,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.8),
                      borderColor: Colors.black.withValues(alpha: 0.5),
                      borderStrokeWidth: 1.0,
                    ),
                  ],
                ),
              MarkerLayer(markers: markers),
            ],
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainer
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMapControlBtn(
                      icon: Icons.add_rounded,
                      tooltip: 'Zoom In',
                      onPressed: _zoomIn,
                    ),
                    const SizedBox(height: 6.0),
                    _buildMapControlBtn(
                      icon: Icons.remove_rounded,
                      tooltip: 'Zoom Out',
                      onPressed: _zoomOut,
                    ),
                    const SizedBox(height: 6.0),
                    _buildMapControlBtn(
                      icon: Icons.my_location_rounded,
                      tooltip: 'Show Current Location',
                      onPressed: _moveToLiveLocation,
                      isLoading: _isLoadingLiveLocation,
                    ),
                    if (widget.locations.isNotEmpty) ...[
                      const SizedBox(height: 6.0),
                      _buildMapControlBtn(
                        icon: Icons.route_rounded,
                        tooltip: 'Recenter Track',
                        onPressed: _recenterMap,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          )
          .animate()
          .fade(duration: 400.ms, delay: 200.ms)
          .slideX(begin: 0.2, end: 0, curve: Curves.easeOutBack),
        ),
        if (widget.locations.isEmpty)
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainer
                          .withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'No route coordinates for this session',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              )
              .animate()
              .fade(duration: 400.ms)
              .slideY(begin: -0.2, end: 0, curve: Curves.easeOut),
            ),
          ),
      ],
    );
  }
}
