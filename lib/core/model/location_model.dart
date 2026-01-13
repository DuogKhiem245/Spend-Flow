class LocationModel {
  final double? latitude;
  final double? longitude;
  final String? address;

  const LocationModel({this.latitude, this.longitude, this.address});

  Map<String, dynamic> toMap() {
    return {'latitude': latitude, 'longitude': longitude, 'address': address};
  }

  factory LocationModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const LocationModel();
    return LocationModel(
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      address: map['address'],
    );
  }
}

class RecentLocationModel {
  final String name;
  final String address;
  final double lat;
  final double lng;
  final int timestamp; 

  RecentLocationModel({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'lat': lat,
      'lng': lng,
      'timestamp': timestamp,
    };
  }

  factory RecentLocationModel.fromMap(Map<String, dynamic> map) {
    return RecentLocationModel(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
      timestamp: map['timestamp'] ?? 0,
    );
  }
}
