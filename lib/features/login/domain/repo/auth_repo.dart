import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/login/data/entities/login_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/onboarding_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/register_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/set_pin_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/verify_otp_usecase_entity.dart';
import 'package:cricklo/features/login/domain/entities/login_response_entity.dart';
import 'package:cricklo/features/login/domain/entities/set_pin_response_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseEntity>> register(
    RegisterUsecaseEntity params,
  );

  Future<Either<Failure, LoginResponseEntity>> verifyOTP(
    VerifyOtpUsecaseEntity params,
  );

  Future<Either<Failure, SetPinResponseEntity>> setPin(
    SetPinUsecaseEntity params,
  );

  Future<Either<Failure, UserEntity>> onboarding(
    OnboardingUsecaseEntity params,
  );

  Future<Either<Failure, LogoutEntity>> login(LoginUsecaseEntity params);
}
