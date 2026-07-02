import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/core/error/failure.dart';

class LocationService {
  /// Checks and requests location permissions.
  /// Returns [Right(true)] if permission is granted, otherwise returns [Left(Failure)].
  Future<Either<Failure, bool>> checkAndRequestPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const Left(Failure.locationServiceDisabled());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left(Failure.locationPermissionDenied());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const Left(Failure.locationPermissionPermanentlyDenied());
    }

    return const Right(true);
  }

  /// Fetches the current location coordinates.
  /// Returns [Right(Position)] on success, [Left(Failure)] on error.
  Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      final permissionResult = await checkAndRequestPermissions();
      return await permissionResult.fold((failure) => Left(failure), (_) async {
        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            timeLimit: Duration(seconds: 10),
          ),
        );
        return Right(position);
      });
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
