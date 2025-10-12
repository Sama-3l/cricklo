import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/account/domain/entities/get_teams_response_entity.dart';
import 'package:cricklo/features/teams/data/datasource/team_datasource_remote.dart';
import 'package:cricklo/features/teams/data/entities/search_player_usecase_entity.dart';
import 'package:cricklo/features/teams/domain/entities/create_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/entities/invite_player_response_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_players_response_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TeamRepoImpl extends TeamRepo {
  final TeamDatasourceRemote _teamDatasourceRemote;

  TeamRepoImpl(this._teamDatasourceRemote);

  @override
  Future<Either<Failure, CreateTeamResponseEntity>> createTeam(
    TeamModel team,
  ) async {
    try {
      final response = await _teamDatasourceRemote.createTeam(team);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        CreateTeamResponseEntity(
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SearchPlayersResponseEntity>> searchPlayers(
    SearchPlayerUsecaseEntity query,
  ) async {
    try {
      final response = await _teamDatasourceRemote.searchPlayers(
        query.query,
        query.page,
      );
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, InvitePlayerResponseEntity>> invitePlayers(
    String teamId,
    List<SearchUserModel> players,
  ) async {
    try {
      final response = await _teamDatasourceRemote.invitePlayers(
        teamId,
        players,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InvitePlayerResponseEntity(
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, GetTeamsResponseEntity>> getTeams() async {
    try {
      final response = await _teamDatasourceRemote.getTeams();
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        GetTeamsResponseEntity(
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, SearchTeamResponseEntity>> searchTeams(
    String query,
  ) async {
    try {
      final response = await _teamDatasourceRemote.searchTeams(query);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        SearchTeamResponseEntity(
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }
}
