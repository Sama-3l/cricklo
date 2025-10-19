import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

class GetProfileResponseEntity {
  final bool success;
  final UserEntity? userEntity;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetProfileResponseEntity({
    required this.success,
    this.userEntity,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
