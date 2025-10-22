import 'package:cricklo/features/tournament/domain/models/remote/create_tournament_response_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';
import 'package:cricklo/services/api_service.dart';

abstract class TournamentDatasourceRemote {
  Future<CreateTournamentResponseModel> createTournament(
    TournamentModel tournament,
  );
}

class TournamentDatasourceRemoteImpl extends TournamentDatasourceRemote {
  final ApiService _apiService;

  TournamentDatasourceRemoteImpl(this._apiService);

  @override
  Future<CreateTournamentResponseModel> createTournament(
    TournamentModel tournament,
  ) {
    return _apiService.createTournament(tournament.toJson());
  }
}
