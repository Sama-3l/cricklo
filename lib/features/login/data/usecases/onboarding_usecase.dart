import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/login/data/entities/onboarding_usecase_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class OnboardingUseCase extends UseCase<UserEntity, OnboardingUsecaseEntity> {
  final AuthRepository repository;

  OnboardingUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(OnboardingUsecaseEntity params) {
    return repository.onboarding(params);
  }
}
