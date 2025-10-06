// domain/usecases/search_location_usecase.dart
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/repo/location_repo.dart';

class SearchLocationUseCase {
  final LocationRepository repository;

  SearchLocationUseCase({required this.repository});

  Future<List<LocationEntity>> call(String query) async {
    return await repository.searchLocations(query);
  }
}
