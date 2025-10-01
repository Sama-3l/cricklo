// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationEntity {
  final String area;
  final String city;
  final String state;
  final (double, double)? coordinates;

  LocationEntity({
    required this.area,
    required this.city,
    required this.state,
    this.coordinates,
  });

  LocationEntity copyWith({
    String? area,
    String? city,
    String? state,
    (double, double)? coordinates,
  }) {
    return LocationEntity(
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
