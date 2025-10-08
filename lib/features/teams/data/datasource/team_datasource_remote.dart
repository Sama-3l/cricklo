import 'package:cricklo/features/teams/domain/models/remote/create_team_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/invite_player_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_players_response_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';
import 'package:cricklo/services/api_service.dart';

abstract class TeamDatasourceRemote {
  Future<CreateTeamResponseModel> createTeam(TeamModel team);
  Future<SearchPlayersResponseModel> searchPlayers(String query);
  Future<InvitePlayerResponseModel> invitePlayers(
    String teamId,
    List<SearchUserModel> players,
  );
}

class TeamDatasourceRemoteImpl extends TeamDatasourceRemote {
  final ApiService _apiService;

  TeamDatasourceRemoteImpl(this._apiService);

  @override
  Future<CreateTeamResponseModel> createTeam(TeamModel team) {
    return _apiService.createTeam(team.toJson());
  }

  @override
  Future<SearchPlayersResponseModel> searchPlayers(String query) async {
    try {
      // Directly call the ApiService (Retrofit)
      final response = await _apiService.searchPlayers(query, 1, 10);
      // Assuming SearchPlayersResponseModel has a field `players`
      return response;
    } catch (e) {
      throw Exception('Failed to search players: $e');
    }
  }

  @override
  Future<InvitePlayerResponseModel> invitePlayers(
    String teamId,
    List<SearchUserModel> players,
  ) async {
    try {
      // Directly call the ApiService (Retrofit)
      final response = await _apiService.invitePlayers(teamId, {
        "players": players.map((e) => {"playerId": e.playerId}).toList(),
      });
      // Assuming SearchPlayersResponseModel has a field `players`
      return response;
    } catch (e) {
      throw Exception('Failed to search players: $e');
    }
  }
}
