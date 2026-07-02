import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:location_tracker/core/error/failure.dart';
import 'package:location_tracker/core/theme/theme_bloc.dart';
import 'package:location_tracker/modules/location_tracker/presentation/bloc/location_bloc.dart';
import 'package:location_tracker/modules/location_tracker/presentation/view/location_list_view.dart';
import 'package:location_tracker/modules/location_tracker/presentation/view/location_map_view.dart';
import 'package:location_tracker/modules/location_tracker/presentation/widgets/battery_card.dart';
import 'package:location_tracker/modules/location_tracker/presentation/widgets/control_panel.dart';
import 'package:location_tracker/utils/responsive/responsive.dart';

class LocationTrackerScreen extends StatefulWidget {
  const LocationTrackerScreen({super.key});

  @override
  State<LocationTrackerScreen> createState() => _LocationTrackerScreenState();
}

class _LocationTrackerScreenState extends State<LocationTrackerScreen> {
  int _selectedViewTab = 0; // 0 = Map, 1 = List
  late final ValueNotifier<Offset?> _fabPositionNotifier;

  @override
  void initState() {
    super.initState();
    _fabPositionNotifier = ValueNotifier<Offset?>(null);
    // Dispatch init event to set up listeners and load session list
    context.read<LocationBloc>().add(const LocationEvent.init());
  }

  @override
  void dispose() {
    _fabPositionNotifier.dispose();
    super.dispose();
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
      case ThemeMode.system:
        return Icons.brightness_auto_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listenWhen: (previous, current) =>
          previous.startTrackingResult != current.startTrackingResult,
      buildWhen: (previous, current) =>
          previous.isTracking != current.isTracking ||
          previous.selectedSessionId != current.selectedSessionId ||
          previous.batteryLevel != current.batteryLevel ||
          previous.currentSessionLocations != current.currentSessionLocations ||
          previous.sessions != current.sessions ||
          previous.isLoadingHistory != current.isLoadingHistory,
      listener: (context, state) {
        state.startTrackingResult.fold(
          () => null,
          (either) => either.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(failure.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
            (success) {
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Background location tracking started!',
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
            },
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/app_logo.png',
                    height: 32.0,
                    width: 32.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Text(
                  'PathFinder Pro',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              BlocBuilder<ThemeBloc, ThemeState>(
                buildWhen: (previous, current) =>
                    previous.themeMode != current.themeMode,
                builder: (context, themeState) {
                  return PopupMenuButton<ThemeMode>(
                    icon: Icon(_getThemeIcon(themeState.themeMode)),
                    tooltip: 'Theme Mode',
                    onSelected: (mode) {
                      context.read<ThemeBloc>().add(ThemeChanged(mode));
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: ThemeMode.system,
                        child: Row(
                          children: [
                            Icon(Icons.brightness_auto_rounded),
                            SizedBox(width: 8.0),
                            Text('System'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: ThemeMode.light,
                        child: Row(
                          children: [
                            Icon(Icons.light_mode_rounded),
                            SizedBox(width: 8.0),
                            Text('Light'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: ThemeMode.dark,
                        child: Row(
                          children: [
                            Icon(Icons.dark_mode_rounded),
                            SizedBox(width: 8.0),
                            Text('Dark'),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_sweep_rounded),
                tooltip: 'Clear history',
                onPressed: () {
                  _showClearAllDialog(context);
                },
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              final defaultPosition = Offset(width - 156.0, height - 80.0);

              return Stack(
                children: [
                  Responsive(
                    mobile: _buildMobileLayout(context, state),
                    tablet: _buildTabletLayout(context, state),
                    desktop: _buildDesktopLayout(context, state),
                  ),
                  if (Responsive.isMobile(context))
                    ValueListenableBuilder<Offset?>(
                      valueListenable: _fabPositionNotifier,
                      builder: (context, fabPos, child) {
                        final currentPosition = fabPos != null
                            ? Offset(
                                fabPos.dx.clamp(16.0, width - 146.0),
                                fabPos.dy.clamp(16.0, height - 64.0),
                              )
                            : defaultPosition;
                        return Positioned(
                          left: currentPosition.dx,
                          top: currentPosition.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              final basePos = _fabPositionNotifier.value ?? defaultPosition;
                              _fabPositionNotifier.value = Offset(
                                (basePos.dx + details.delta.dx).clamp(16.0, width - 146.0),
                                (basePos.dy + details.delta.dy).clamp(16.0, height - 64.0),
                              );
                            },
                            child: FloatingActionButton.extended(
                              onPressed: () => _showSessionsBottomSheet(context, state),
                              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                              foregroundColor: Theme.of(context).colorScheme.primary,
                              icon: const Icon(Icons.history_rounded),
                              label: const Text('Sessions'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outlineVariant,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, LocationState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            BatteryCard(batteryLevel: state.batteryLevel),
            const SizedBox(height: 12.0),
            ControlPanel(
              isTracking: state.isTracking,
              activeSessionId: state.selectedSessionId,
              onStart: () => context.read<LocationBloc>().add(
                const LocationEvent.startTracking(),
              ),
              onStop: () => context.read<LocationBloc>().add(
                const LocationEvent.stopTracking(),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: _selectedViewTab,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                thumbColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                children: {
                  0: _buildTabLabel(
                    Icons.map_rounded,
                    'Map View',
                    _selectedViewTab == 0,
                  ),
                  1: _buildTabLabel(
                    Icons.list_alt_rounded,
                    'List View',
                    _selectedViewTab == 1,
                  ),
                },
                onValueChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedViewTab = val;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 12.0),
            _selectedViewTab == 0
                ? SizedBox(
                    height: 450.0,
                    child: LocationMapView(locations: state.currentSessionLocations),
                  )
                : LocationListView(
                    locations: state.currentSessionLocations,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // --- TABLET / DESKTOP LAYOUT ---
  Widget _buildTabletLayout(BuildContext context, LocationState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Panel
          SizedBox(
            width: 320.0,
            child: Column(
              children: [
                BatteryCard(batteryLevel: state.batteryLevel),
                const SizedBox(height: 12.0),
                ControlPanel(
                  isTracking: state.isTracking,
                  activeSessionId: state.selectedSessionId,
                  onStart: () => context.read<LocationBloc>().add(
                    const LocationEvent.startTracking(),
                  ),
                  onStop: () => context.read<LocationBloc>().add(
                    const LocationEvent.stopTracking(),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(child: _buildSessionHistoryPanel(context, state)),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          // Main content: Side-by-side Map & List
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                        child: Text(
                          'Route Trajectory',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: LocationMapView(
                          locations: state.currentSessionLocations,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                        child: Text(
                          'Location Records (${state.currentSessionLocations.length})',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: LocationListView(
                          locations: state.currentSessionLocations,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, LocationState state) {
    // Desktop could have a wider sidebar panel, let's make it 380px wide
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Panel
          SizedBox(
            width: 380.0,
            child: Column(
              children: [
                BatteryCard(batteryLevel: state.batteryLevel),
                const SizedBox(height: 16.0),
                ControlPanel(
                  isTracking: state.isTracking,
                  activeSessionId: state.selectedSessionId,
                  onStart: () => context.read<LocationBloc>().add(
                    const LocationEvent.startTracking(),
                  ),
                  onStop: () => context.read<LocationBloc>().add(
                    const LocationEvent.stopTracking(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(child: _buildSessionHistoryPanel(context, state)),
              ],
            ),
          ),
          const SizedBox(width: 24.0),
          // Main content: side-by-side
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
                        child: Text(
                          'Route Map',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: LocationMapView(
                          locations: state.currentSessionLocations,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
                        child: Text(
                          'Location Log History (${state.currentSessionLocations.length})',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: LocationListView(
                          locations: state.currentSessionLocations,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- SUB-COMPONENTS ---
  Widget _buildTabLabel(IconData icon, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16.0,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar / panel for lists of session history
  Widget _buildSessionHistoryPanel(BuildContext context, LocationState state) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recorded Sessions',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: state.sessions.isEmpty
                  ? Center(
                      child: Text(
                        'No saved sessions',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.sessions.length,
                      itemBuilder: (context, index) {
                        final session = state.sessions[index];
                        final id = session['session_id'] as String;
                        final points = session['point_count'] as int;
                        final isSelected = id == state.selectedSessionId;

                        // Parse earliest point timestamp
                        final startTimeRaw = session['start_time'] as String;
                        final startTime =
                            DateTime.tryParse(startTimeRaw) ?? DateTime.now();
                        final timeFormatted = DateFormat(
                          'MMM dd, hh:mm a',
                        ).format(startTime);

                        return _buildSessionListItem(
                          context: context,
                          id: id,
                          points: points,
                          timeFormatted: timeFormatted,
                          isSelected: isSelected,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionListItem({
    required BuildContext context,
    required String id,
    required int points,
    required String timeFormatted,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.4)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 2.0,
        ),
        title: Text(
          id,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
        subtitle: Text(
          '$timeFormatted • $points points',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 11.0,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline_rounded,
            size: 18.0,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onPressed: () {
            _showDeleteSessionDialog(context, id);
          },
        ),
        onTap: () {
          context.read<LocationBloc>().add(LocationEvent.selectSession(id));
        },
      ),
    );
  }

  // --- MOBILE DIALOGS & DRAWER ---
  void _showSessionsBottomSheet(BuildContext context, LocationState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previous, current) =>
              previous.sessions != current.sessions ||
              previous.selectedSessionId != current.selectedSessionId ||
              previous.isLoadingHistory != current.isLoadingHistory,
          builder: (context, latestState) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Tracking Session',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    Expanded(
                      child: latestState.sessions.isEmpty
                          ? Center(
                              child: Text(
                                'No saved sessions found',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: latestState.sessions.length,
                              itemBuilder: (context, index) {
                                final session = latestState.sessions[index];
                                final id = session['session_id'] as String;
                                final points = session['point_count'] as int;
                                final isSelected =
                                    id == latestState.selectedSessionId;

                                final startTimeRaw =
                                    session['start_time'] as String;
                                final startTime =
                                    DateTime.tryParse(startTimeRaw) ??
                                    DateTime.now();
                                final timeFormatted = DateFormat(
                                  'MMM dd, hh:mm a',
                                ).format(startTime);

                                return _buildSessionListItem(
                                  context: context,
                                  id: id,
                                  points: points,
                                  timeFormatted: timeFormatted,
                                  isSelected: isSelected,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteSessionDialog(BuildContext context, String sessionId) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: const Text('Delete Session?'),
        content: Text(
          'Are you sure you want to delete session $sessionId? All recorded locations will be permanently removed.',
        ),
        actions: [
          TextButton(
            child: Text(
              'CANCEL',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onPressed: () => Navigator.pop(dialogCtx),
          ),
          TextButton(
            child: Text(
              'DELETE',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onPressed: () {
              context.read<LocationBloc>().add(
                LocationEvent.deleteSession(sessionId),
              );
              Navigator.pop(dialogCtx);
            },
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: const Text('Clear All Data?'),
        content: const Text(
          'Are you sure you want to permanently delete all tracking sessions and coordinates from the local database? This cannot be undone.',
        ),
        actions: [
          TextButton(
            child: Text(
              'CANCEL',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onPressed: () => Navigator.pop(dialogCtx),
          ),
          TextButton(
            child: Text(
              'CLEAR ALL',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onPressed: () {
              // Delete session loop or custom db clear, let's delete all sessions
              final sessions = context.read<LocationBloc>().state.sessions;
              for (final s in sessions) {
                context.read<LocationBloc>().add(
                  LocationEvent.deleteSession(s['session_id']),
                );
              }
              Navigator.pop(dialogCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All local logs cleared.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
