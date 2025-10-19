import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/account/domain/entities/get_profile_response_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MainAppRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, GetProfileResponseEntity>> getProfile(String id);
  Future<Either<Failure, LogoutEntity>> logout();
}
