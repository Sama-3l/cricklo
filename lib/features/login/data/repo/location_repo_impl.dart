// data/repositories/location_repository_impl.dart
import 'package:cricklo/features/login/data/datasource/location_datasource.dart';
import 'package:cricklo/features/login/domain/repo/location_repo.dart';

import '../../domain/entities/location_entity.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<LocationEntity>> searchLocations(String query) async {
    final models = await remoteDataSource.searchLocations(query);
    return models.map((e) => e.toEntity()).toList();
  }
}
