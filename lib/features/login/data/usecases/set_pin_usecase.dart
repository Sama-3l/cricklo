import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/login/data/entities/set_pin_usecase_entity.dart';
import 'package:cricklo/features/login/domain/entities/set_pin_response_entity.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SetPinUsecase extends UseCase<SetPinResponseEntity, SetPinUsecaseEntity> {
  final AuthRepository repository;

  SetPinUsecase(this.repository);

  @override
  Future<Either<Failure, SetPinResponseEntity>> call(
    SetPinUsecaseEntity entity,
  ) {
    return repository.setPin(entity);
  }
}
