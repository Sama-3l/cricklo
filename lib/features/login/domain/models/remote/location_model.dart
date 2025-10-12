// data/models/location_model.dar

import 'package:cricklo/features/login/domain/entities/location_entity.dart';

class LocationModel {
  final String? location;
  final String area;
  final String city;
  final String state;
  double? lat;
  double? lng;

  LocationModel({
    this.location,
    required this.area,
    required this.city,
    required this.state,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location: json['location'] ?? '',
      area: json['area'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      lat: double.tryParse(json['lat'].toString()) ?? 0,
      lng: double.tryParse(json['lon'].toString()) ?? 0,
    );
  }

  factory LocationModel.fromEntity(LocationEntity location) {
    return LocationModel(
      location: location.location,
      area: location.area,
      city: location.city,
      state: location.state,
      lat: location.lat,
      lng: location.lng,
    );
  }

  Map<String, dynamic> toJson() {
    return {"location": location, "area": area, "city": city, "state": state};
  }

  LocationEntity toEntity() {
    return LocationEntity(
      location: location,
      area: area,
      city: city,
      state: state,
      lat: lat,
      lng: lng,
    );
  }
}
