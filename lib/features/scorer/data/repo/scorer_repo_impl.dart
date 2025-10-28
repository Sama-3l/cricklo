import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/scorer/data/datasource/scorer_datasource.dart';
import 'package:cricklo/features/scorer/data/entities/scorer_request_usecase_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/broadcast_wrapper_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/get_match_state_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_response_entity.dart';
import 'package:cricklo/features/scorer/domain/repo/scorer_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ScorerRepoImpl extends ScorerRepo {
  final ScorerDatasourceRemote remoteDataSource;

  ScorerRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ScorerResponseEntity>> startScoring(
    ScorerRequestUsecaseEntity body,
  ) async {
    try {
      final response = await remoteDataSource.startScoring(body.toJson());
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data?['error']?['code'].toString();
      final message = data?['error']?['message'];
      return Right(
        ScorerResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ScorerResponseEntity>> updateScoring(
    ScorerRequestUsecaseEntity body,
  ) async {
    try {
      final response = await remoteDataSource.updateScoring(body.toJson());
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data?['error']?['code'].toString();
      final message = data?['error']?['message'];
      return Right(
        ScorerResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ScorerResponseEntity>> endOver(
    ScorerRequestUsecaseEntity body,
  ) async {
    try {
      final response = await remoteDataSource.endOver(body.toJson());
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data?['error']?['code'].toString();
      final message = data?['error']?['message'];
      return Right(
        ScorerResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ScorerResponseEntity>> scorerInningsChange(
    ScorerRequestUsecaseEntity request,
  ) async {
    try {
      final response = await remoteDataSource.scorerInningsChange(
        request.toJson(),
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data?['error']?['code'].toString();
      final message = data?['error']?['message'];

      return Right(
        ScorerResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ScorerResponseEntity>> scorerComplete(
    ScorerRequestUsecaseEntity request,
  ) async {
    try {
      final response = await remoteDataSource.scorerComplete(request.toJson());
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data?['error']?['code'].toString();
      final message = data?['error']?['message'];

      return Right(
        ScorerResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, GetMatchStateResponseEntity>> getMatchState(
    String matchId,
  ) async {
    try {
      final response = await remoteDataSource.getMatchState(matchId);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data?['error']?['code'].toString();
      final message = data?['error']?['message'];

      return Right(
        GetMatchStateResponseEntity(
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
  Stream<Either<Failure, BroadcastWrapperEntity>> listenToMatchStream(
    String matchId,
    BuildContext context,
  ) async* {
    try {
      yield* remoteDataSource
          .listenToMatchStream(matchId, context)
          .map((entity) => Right(entity));
    } catch (e) {
      yield Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }
}
