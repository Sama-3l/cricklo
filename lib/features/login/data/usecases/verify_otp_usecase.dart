import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/login/data/entities/verify_otp_usecase_entity.dart';
import 'package:cricklo/features/login/domain/entities/login_response_entity.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class VerifyOtpUsecase
    extends UseCase<LoginResponseEntity, VerifyOtpUsecaseEntity> {
  final AuthRepository _authRepository;

  VerifyOtpUsecase(this._authRepository);

  @override
  Future<Either<Failure, LoginResponseEntity>> call(
    VerifyOtpUsecaseEntity entity,
  ) {
    return _authRepository.verifyOTP(entity);
  }
}
