import 'package:cricklo/features/login/domain/entities/login_response_entity.dart';

class LoginResponseModel {
  final bool success;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  LoginResponseModel({
    required this.success,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] == true) {
      return LoginResponseModel(success: true, message: json["message"]);
    } else {
      final error = json["error"];
      return LoginResponseModel(
        success: false,
        status: error?["status"],
        errorMessage: error?["message"],
        errorCode: error?["code"],
      );
    }
  }

  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      success: success,
      message: message,
      status: status,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }
}
