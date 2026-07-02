import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.databaseError(String message) = _DatabaseError;
  const factory Failure.locationPermissionDenied() = _LocationPermissionDenied;
  const factory Failure.locationPermissionPermanentlyDenied() = _LocationPermissionPermanentlyDenied;
  const factory Failure.locationServiceDisabled() = _LocationServiceDisabled;
  const factory Failure.unknownError(String message) = _UnknownError;
}

extension FailureMessage on Failure {
  String get message {
    return when(
      databaseError: (msg) => 'Database Error: $msg',
      locationPermissionDenied: () => 'Location permission was denied.',
      locationPermissionPermanentlyDenied: () => 'Location permissions are permanently denied. Please enable them in settings.',
      locationServiceDisabled: () => 'Location services are disabled on this device.',
      unknownError: (msg) => 'An unknown error occurred: $msg',
    );
  }
}
