import 'package:cricklo/features/notifications/domain/models/remote/invite_response_response_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/create_group_table_response_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/create_tournament_response_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/get_all_tournaments_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/get_tournament_details_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';
import 'package:cricklo/services/api_service.dart';

abstract class TournamentDatasourceRemote {
  Future<CreateTournamentResponseModel> createTournament(
    TournamentModel tournament,
  );
  Future<GetAllTournamentsModel> getAllTournaments();
  Future<InviteResponseResponseModel> inviteModerators(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<InviteResponseResponseModel> inviteTeams(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<InviteResponseResponseModel> applyTournament(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<GetTournamentDetailsModel> getTournamentDetails(String tournamentId);
  Future<InviteResponseResponseModel> createGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<InviteResponseResponseModel> addToGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<InviteResponseResponseModel> deleteGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<InviteResponseResponseModel> editGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<CreateGroupTableResponseModel> createGroupMatches(String tournamentId);
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

  @override
  Future<GetAllTournamentsModel> getAllTournaments() {
    return _apiService.getAllTournaments();
  }

  @override
  Future<InviteResponseResponseModel> inviteModerators(tournamentId, body) {
    return _apiService.inviteModerators(tournamentId, body);
  }

  @override
  Future<InviteResponseResponseModel> inviteTeams(tournamentId, body) {
    return _apiService.inviteTeams(tournamentId, body);
  }

  @override
  Future<InviteResponseResponseModel> applyTournament(tournamentId, body) {
    return _apiService.tournamentApply(tournamentId, body);
  }

  @override
  Future<GetTournamentDetailsModel> getTournamentDetails(String tournamentId) {
    return _apiService.getTournamentDetails(tournamentId);
  }

  @override
  Future<InviteResponseResponseModel> createGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) {
    return _apiService.tournamentCreateGroup(tournamentId, body);
  }

  @override
  Future<InviteResponseResponseModel> addToGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) {
    return _apiService.tournamentAddToGroup(tournamentId, body);
  }

  @override
  Future<InviteResponseResponseModel> deleteGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) {
    return _apiService.tournamentDeleteGroup(tournamentId, body);
  }

  @override
  Future<InviteResponseResponseModel> editGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) {
    return _apiService.tournamentEditGroup(tournamentId, body);
  }

  @override
  Future<CreateGroupTableResponseModel> createGroupMatches(
    String tournamentId,
  ) {
    return _apiService.createTournamentMatches(tournamentId, {});
  }
}
