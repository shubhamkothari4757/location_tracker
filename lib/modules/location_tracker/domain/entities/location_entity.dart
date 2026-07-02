class LocationEntity {
  final int? id;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double accuracy;
  final String sessionId;

  const LocationEntity({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.accuracy,
    required this.sessionId,
  });

  // helper method to format values cleanly
  String get formattedCoordinates => 
      '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
}
