// data/models/location_model.dar

import 'package:cricklo/features/login/domain/entities/location_entity.dart';

class LocationModel {
  final String area;
  final String city;
  final String state;
  final double lat;
  final double lng;

  LocationModel({
    required this.area,
    required this.city,
    required this.state,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final address = json['address'] ?? {};
    return LocationModel(
      area: address['neighbourhood'] ?? '',
      city: address['city'] ?? '',
      state: address['state'] ?? '',
      lat: double.tryParse(json['lat'].toString()) ?? 0,
      lng: double.tryParse(json['lon'].toString()) ?? 0,
    );
  }

  factory LocationModel.fromEntity(LocationEntity location) {
    return LocationModel(
      area: location.area,
      city: location.city,
      state: location.state,
      lat: location.lat,
      lng: location.lng,
    );
  }

  Map<String, dynamic> toJson() {
    return {"area": area, "city": city, "state": state};
  }

  LocationEntity toEntity() {
    return LocationEntity(
      area: area,
      city: city,
      state: state,
      lat: lat,
      lng: lng,
    );
  }
}
