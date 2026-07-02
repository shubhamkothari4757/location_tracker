import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/modules/location_tracker/data/models/location_model.dart';

void main() {
  group('LocationModel Tests', () {
    test('LocationModel serializes to JSON correctly', () {
      const model = LocationModel(
        id: 1,
        latitude: 37.7749,
        longitude: -122.4194,
        timestamp: '2026-06-30T12:00:00Z',
        accuracy: 15.0,
        sessionId: 'test_session_123',
      );

      final json = model.toJson();

      expect(json['id'], equals(1));
      expect(json['latitude'], equals(37.7749));
      expect(json['longitude'], equals(-122.4194));
      expect(json['timestamp'], equals('2026-06-30T12:00:00Z'));
      expect(json['accuracy'], equals(15.0));
      expect(json['session_id'], equals('test_session_123'));
    });

    test('LocationModel deserializes from JSON correctly', () {
      final json = {
        'id': 2,
        'latitude': 40.7128,
        'longitude': -74.0060,
        'timestamp': '2026-06-30T13:00:00Z',
        'accuracy': 5.0,
        'session_id': 'test_session_456',
      };

      final model = LocationModel.fromJson(json);

      expect(model.id, equals(2));
      expect(model.latitude, equals(40.7128));
      expect(model.longitude, equals(-74.0060));
      expect(model.timestamp, equals('2026-06-30T13:00:00Z'));
      expect(model.accuracy, equals(5.0));
      expect(model.sessionId, equals('test_session_456'));
    });
  });
}
