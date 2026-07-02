import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_tracker/modules/location_tracker/domain/entities/location_entity.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    int? id,
    required double latitude,
    required double longitude,
    required String timestamp, // Stored as ISO-8601 String for SQLite compatibility
    required double accuracy,
    @JsonKey(name: 'session_id') required String sessionId,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  // Convert Entity to Model
  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      timestamp: entity.timestamp.toIso8601String(),
      accuracy: entity.accuracy,
      sessionId: entity.sessionId,
    );
  }
}

extension LocationModelToEntity on LocationModel {
  // Convert Model to Entity
  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.parse(timestamp),
      accuracy: accuracy,
      sessionId: sessionId,
    );
  }
}
