import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/login/data/entities/register_usecase_entity.dart';
import 'package:cricklo/features/login/domain/entities/login_response_entity.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase
    extends UseCase<LoginResponseEntity, RegisterUsecaseEntity> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);
  @override
  Future<Either<Failure, LoginResponseEntity>> call(
    RegisterUsecaseEntity entity,
  ) {
    return repository.register(entity);
  }
}
