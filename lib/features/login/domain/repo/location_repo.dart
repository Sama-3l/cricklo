// domain/repositories/location_repository.dart
import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<List<LocationEntity>> searchLocations(String query);
}
