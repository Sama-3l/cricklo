import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/follow/data/datasource/follow_datasource_remote.dart';
import 'package:cricklo/features/follow/domain/entities/follow_response_entity.dart';
import 'package:cricklo/features/follow/domain/entities/get_followers_entity.dart';
import 'package:cricklo/features/follow/domain/repo/follow_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class FollowRepoImpl extends FollowRepo {
  final FollowDatasourceRemote _datasourceRemote;

  FollowRepoImpl(this._datasourceRemote);

  @override
  Future<Either<Failure, FollowResponseEntity>> follow(
    String entityId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.follow(entityId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        FollowResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FollowResponseEntity>> unfollow(
    String entityId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.follow(entityId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        FollowResponseEntity(success: false, message: message, errorCode: code),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetFollowersEntity>> getFollowers(
    String entityId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _datasourceRemote.getFollowers(entityId, body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        GetFollowersEntity(
          success: false,
          followers: [],
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
