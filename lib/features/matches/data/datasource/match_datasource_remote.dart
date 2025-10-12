import 'package:cricklo/features/matches/data/entities/create_match_usecase_entity.dart';
import 'package:cricklo/features/matches/domain/models/remote/create_match_response_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/get_user_matches_response_model.dart';
import 'package:cricklo/services/api_service.dart';

abstract class MatchDatasourceRemote {
  Future<CreateMatchResponseModel> createMatch(CreateMatchUsecaseEntity match);
  Future<GetUserMatchesResponseModel> getUserMatches();
}

class MatchDatasourceRemoteImpl extends MatchDatasourceRemote {
  final ApiService _apiService;

  MatchDatasourceRemoteImpl(this._apiService);
  @override
  Future<CreateMatchResponseModel> createMatch(CreateMatchUsecaseEntity match) {
    return _apiService.createMatch(match.toJson());
  }

  @override
  Future<GetUserMatchesResponseModel> getUserMatches() {
    return _apiService.getUserMatches();
  }
}
