class Presence {
  int id;
  String imagePath;
  double latitude;
  double longitude;
  DateTime timestamp;

  Presence({
    required this.id,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Presence.fromMap(Map<String, dynamic> map) {
    return Presence(
      id: map['id'],
      imagePath: map['imagePath'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
