import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/teams/domain/entities/create_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/entities/invite_player_response_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_players_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';
import 'package:dartz/dartz.dart';

abstract class TeamRepo {
  Future<Either<Failure, CreateTeamResponseEntity>> createTeam(TeamModel team);
  Future<Either<Failure, SearchPlayersResponseEntity>> searchPlayers(
    String query,
  );
  Future<Either<Failure, InvitePlayerResponseEntity>> invitePlayers(
    String teamId,
    List<SearchUserModel> body,
  );
}
