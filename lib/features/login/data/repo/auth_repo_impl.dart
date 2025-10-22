import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/data/datasource/login_remote_datasource.dart';
import 'package:cricklo/features/login/data/entities/login_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/onboarding_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/register_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/set_pin_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/verify_otp_usecase_entity.dart';
import 'package:cricklo/features/login/domain/entities/login_response_entity.dart';
import 'package:cricklo/features/login/domain/entities/set_pin_response_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginResponseEntity>> register(
    RegisterUsecaseEntity params,
  ) async {
    try {
      final response = await remoteDataSource.login(
        params.number,
        params.countryCode,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      if (code == "USER_ALREADY_EXISTS") {
        return Right(
          LoginResponseEntity(
            success: false,
            message: message ?? "User already exists",
            errorCode: code,
          ),
        );
      }

      if (code == "OTP_SEND_LOCK") {
        return Right(
          LoginResponseEntity(
            success: false,
            message: message ?? "OTP sending locked. Try later.",
            errorCode: code,
          ),
        );
      }

      return Left(ServerFailure(message: message ?? "Unexpected server error"));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> verifyOTP(
    VerifyOtpUsecaseEntity params,
  ) async {
    try {
      final response = await remoteDataSource.verifyOTP(
        params.number,
        params.otp,
        params.countryCode,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;
      final status = data?['error']?['status'] as int;
      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      if (status == 500) {
        return Right(
          LoginResponseEntity(
            success: false,
            message: message ?? "User already exists",
            errorCode: code,
            status: status,
          ),
        );
      }

      if (code == "OTP_EXPIRED") {
        return Right(
          LoginResponseEntity(
            success: false,
            message: message ?? "User already exists",
            errorCode: code,
          ),
        );
      }

      if (code == "VALIDATION_ERROR") {
        return Right(
          LoginResponseEntity(
            success: false,
            message: message ?? "OTP sending locked. Try later.",
            errorCode: code,
          ),
        );
      }

      return Left(ServerFailure(message: message ?? "Unexpected server error"));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, SetPinResponseEntity>> setPin(
    SetPinUsecaseEntity params,
  ) async {
    try {
      final response = await remoteDataSource.setPin(params.number, params.pin);
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> onboarding(
    OnboardingUsecaseEntity params,
  ) async {
    try {
      final response = await remoteDataSource.onboarding(params.toJson());

      /// REMOVE LATER ONCE ADDED TO PAYLOAD FROM BACKEND
      BatterType? batterType;
      switch (params.batsmanType) {
        case 'LEFT_HANDED':
          batterType = BatterType.leftHand;
          break;
        case 'RIGHT_HANDED':
          batterType = BatterType.rightHand;
          break;
        default:
          batterType = null;
      }

      BowlerType? bowlerType;
      switch (params.bowlerType) {
        case 'LEFT_ARM_LEGSPIN':
          bowlerType = BowlerType.leftArmSpin;
          break;
        case 'LEFT_ARM_FAST':
          bowlerType = BowlerType.leftArmPace;
          break;
        case 'RIGHT_ARM_LEGSPIN':
          bowlerType = BowlerType.rightArmSpin;
          break;
        case 'RIGHT_ARM_FAST':
          bowlerType = BowlerType.rightArmPace;
          break;
        default:
          bowlerType = null;
      }

      final userModel = response.copyWith(
        phoneNumber: params.phoneNumber,
        batterType: batterType,
        bowlerType: bowlerType,
      );

      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutEntity>> login(LoginUsecaseEntity params) async {
    try {
      final response = await remoteDataSource.loginUsingPin(params.toJson());
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
