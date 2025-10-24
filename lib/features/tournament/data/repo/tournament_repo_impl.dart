import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/datasource/tournament_datasource_remote.dart';
import 'package:cricklo/features/tournament/domain/entities/create_tournament_response_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/get_all_tournaments_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/get_tournament_details_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TournamentRepoImpl extends TournamentRepo {
  final TournamentDatasourceRemote _datasourceRemote;

  TournamentRepoImpl(this._datasourceRemote);

  @override
  Future<Either<Failure, CreateTournamentResponseEntity>> createTournament(
    TournamentEntity entity,
  ) async {
    try {
      final response = await _datasourceRemote.createTournament(
        TournamentModel.fromEntity(entity),
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        CreateTournamentResponseEntity(
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
  Future<Either<Failure, GetAllTournamentsEntity>> getAllTournaments() async {
    try {
      final response = await _datasourceRemote.getAllTournaments();
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        GetAllTournamentsEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> inviteModerators(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.inviteModerators(
        tournamentId,
        body,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> inviteTeams(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.inviteTeams(tournamentId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> tournamentApply(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.applyTournament(
        tournamentId,
        body,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
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
  Future<Either<Failure, GetTournamentDetailsEntity>> getTournamentDetails(
    String tournamentId,
  ) async {
    try {
      final response = await _datasourceRemote.getTournamentDetails(
        tournamentId,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        GetTournamentDetailsEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> tournamentCreateGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.createGroup(tournamentId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> addToGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.addToGroup(tournamentId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> deleteGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.deleteGroup(tournamentId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
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
  Future<Either<Failure, InviteResponseResponseEntity>> editGroup(
    String tournamentId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.editGroup(tournamentId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        InviteResponseResponseEntity(
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
