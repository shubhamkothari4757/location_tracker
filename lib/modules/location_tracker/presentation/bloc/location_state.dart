part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    required bool isTracking,
    required int batteryLevel,
    required List<LocationEntity> currentSessionLocations,
    required List<Map<String, dynamic>> sessions,
    required String? selectedSessionId,
    required Option<Either<Failure, bool>> startTrackingResult,
    required Option<Either<Failure, List<LocationEntity>>> loadLocationsResult,
    required bool isLoadingHistory,
  }) = _LocationState;

  factory LocationState.initial() {
    return LocationState(
      isTracking: false,
      batteryLevel: -1,
      currentSessionLocations: const [],
      sessions: const [],
      selectedSessionId: null,
      startTrackingResult: none(),
      loadLocationsResult: none(),
      isLoadingHistory: false,
    );
  }
}
