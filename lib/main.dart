import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/config/router/route_config.dart';
import 'package:location_tracker/core/di/service_locator.dart';
import 'package:location_tracker/core/theme/app_theme.dart';
import 'package:location_tracker/core/theme/theme_bloc.dart';
import 'package:location_tracker/modules/location_tracker/data/datasources/background_tracker_service.dart';
import 'package:location_tracker/modules/location_tracker/presentation/bloc/location_bloc.dart';

void main() async {
  // Ensure Flutter engine bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Dependency Injection (GetIt)
  await setupLocator();

  // Initialize background location service configurations
  await BackgroundTrackerService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouterConfig.buildInitialRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(const ThemeInit()),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => serviceLocator<LocationBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) => previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'PathFinder Pro',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
