// ignore_for_file: public_member_api_docs, sort_constructors_first
// domain/entities/location_entity.dart
class LocationEntity {
  final String area;
  final String city;
  final String state;
  final double lat;
  final double lng;

  LocationEntity({
    required this.area,
    required this.city,
    required this.state,
    required this.lat,
    required this.lng,
  });

  LocationEntity copyWith({
    String? area,
    String? city,
    String? state,
    double? lat,
    double? lng,
  }) {
    return LocationEntity(
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
