import 'package:get_it/get_it.dart';
import 'package:location_tracker/core/services/battery_service.dart';
import 'package:location_tracker/core/services/db_helper.dart';
import 'package:location_tracker/modules/location_tracker/data/datasources/location_service.dart';
import 'package:location_tracker/modules/location_tracker/presentation/bloc/location_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  // Core Services
  final dbHelper = DBHelper();
  await dbHelper.database; // Trigger database initialization
  serviceLocator.registerSingleton<DBHelper>(dbHelper);

  serviceLocator.registerLazySingleton<BatteryService>(() => BatteryService());
  serviceLocator.registerLazySingleton<LocationService>(() => LocationService());

  // Presentation (BLoCs)
  serviceLocator.registerFactory<LocationBloc>(
    () => LocationBloc(
      dbHelper: serviceLocator<DBHelper>(),
      batteryService: serviceLocator<BatteryService>(),
      locationService: serviceLocator<LocationService>(),
    ),
  );
}
