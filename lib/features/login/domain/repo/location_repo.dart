// domain/repositories/location_repository.dart
import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<Map<String, dynamic>> searchLocations(String query);
}
