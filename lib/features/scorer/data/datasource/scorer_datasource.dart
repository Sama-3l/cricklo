import 'package:cricklo/features/scorer/domain/entities/broadcast_wrapper_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/get_match_state_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/scorer_response_model.dart';
import 'package:cricklo/services/api_service.dart';
import 'package:cricklo/services/socket_service.dart';

abstract class ScorerDatasourceRemote {
  Future<ScorerResponseModel> startScoring(Map<String, dynamic> body);
  Future<ScorerResponseModel> updateScoring(Map<String, dynamic> body);
  Future<ScorerResponseModel> endOver(Map<String, dynamic> body);
  Future<ScorerResponseModel> scorerInningsChange(Map<String, dynamic> body);
  Future<ScorerResponseModel> scorerComplete(Map<String, dynamic> request);
  Future<GetMatchStateResponseModel> getMatchState(String matchId);
  Stream<BroadcastWrapperEntity> listenToMatchStream(String matchId);
}

class ScorerDatasourceRemoteImpl extends ScorerDatasourceRemote {
  final ApiService _apiService;
  final SocketService _socketService;

  ScorerDatasourceRemoteImpl(this._apiService, this._socketService);

  @override
  Future<ScorerResponseModel> startScoring(Map<String, dynamic> body) {
    return _apiService.startScoring(body);
  }

  @override
  Future<ScorerResponseModel> updateScoring(Map<String, dynamic> body) {
    return _apiService.updateScoring(body);
  }

  @override
  Future<ScorerResponseModel> endOver(Map<String, dynamic> body) {
    return _apiService.endOver(body);
  }

  @override
  Future<ScorerResponseModel> scorerInningsChange(Map<String, dynamic> body) {
    return _apiService.scorerInningsChange(body);
  }

  @override
  Future<ScorerResponseModel> scorerComplete(Map<String, dynamic> request) {
    return _apiService.scorerComplete(request);
  }

  @override
  Future<GetMatchStateResponseModel> getMatchState(String matchId) {
    return _apiService.getMatchState(matchId);
  }

  @override
  Stream<BroadcastWrapperEntity> listenToMatchStream(String matchId) {
    _socketService.connectToMatchRoom(matchId);
    return _socketService.listenToMatchStream().map(
      (model) => model.toEntity(),
    );
  }
}
