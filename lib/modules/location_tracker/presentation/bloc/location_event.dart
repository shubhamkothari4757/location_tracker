part of 'location_bloc.dart';

@freezed
class LocationEvent with _$LocationEvent {
  const factory LocationEvent.init() = _Init;
  const factory LocationEvent.startTracking() = _StartTracking;
  const factory LocationEvent.stopTracking() = _StopTracking;
  const factory LocationEvent.loadSessions() = _LoadSessions;
  const factory LocationEvent.selectSession(String? sessionId) = _SelectSession;
  const factory LocationEvent.updateBattery() = _UpdateBattery;
  const factory LocationEvent.onLocationCaptured(LocationModel location) = _OnLocationCaptured;
  const factory LocationEvent.deleteSession(String sessionId) = _DeleteSession;
}
