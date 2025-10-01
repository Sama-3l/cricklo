import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/login/data/entities/login_usecase_entity.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends UseCase<LogoutEntity, LoginUsecaseEntity> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, LogoutEntity>> call(LoginUsecaseEntity params) {
    return repository.login(params);
  }
}
