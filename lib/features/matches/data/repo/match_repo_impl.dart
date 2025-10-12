import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/matches/data/datasource/match_datasource_remote.dart';
import 'package:cricklo/features/matches/data/entities/create_match_usecase_entity.dart';
import 'package:cricklo/features/matches/domain/entities/create_match_response_entity.dart';
import 'package:cricklo/features/matches/domain/entities/get_user_matches_response_entity.dart';
import 'package:cricklo/features/matches/domain/repo/match_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MatchRepoImpl extends MatchRepo {
  final MatchDatasourceRemote remoteDataSource;

  MatchRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CreateMatchResponseEntity>> createMatch(
    CreateMatchUsecaseEntity entity,
  ) async {
    try {
      final response = await remoteDataSource.createMatch(entity);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        CreateMatchResponseEntity(
          matchId: '',
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, GetUserMatchesResponseEntity>> getUserMatches() async {
    try {
      final response = await remoteDataSource.getUserMatches();
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        GetUserMatchesResponseEntity(
          matches: [],
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }
}
