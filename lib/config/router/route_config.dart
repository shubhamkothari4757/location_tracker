import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location_tracker/config/router/app_routes.dart';
import 'package:location_tracker/modules/location_tracker/presentation/screen/location_tracker_screen.dart';

class AppRouterConfig {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter buildInitialRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.home,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const LocationTrackerScreen(),
        ),
      ],
    );
  }
}
