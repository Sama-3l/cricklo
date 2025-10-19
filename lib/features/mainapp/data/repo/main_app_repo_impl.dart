import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/account/domain/entities/get_profile_response_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/data/datasource/main_app_remote_datasource.dart';
import 'package:cricklo/features/mainapp/domain/repo/main_app_repo.dart';
import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';
import 'package:dartz/dartz.dart';

class MainAppRepoImpl implements MainAppRepository {
  final MainAppRemoteDatasource remoteDataSource;

  MainAppRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final response = await remoteDataSource.getCurrentUser();
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetProfileResponseEntity>> getProfile(
    String id,
  ) async {
    try {
      final response = await remoteDataSource.getProfile(id);
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LogoutEntity>> logout() async {
    try {
      final response = await remoteDataSource.logout();
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
