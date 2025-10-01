import 'package:cricklo/features/login/domain/entities/set_pin_response_entity.dart';

class SetPinResponseModel {
  final bool success;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;
  final bool? onboarded;

  SetPinResponseModel({
    required this.success,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
    this.onboarded,
  });

  factory SetPinResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] == true) {
      return SetPinResponseModel(
        success: true,
        message: json["message"],
        onboarded: json["onboarded"],
      );
    } else {
      final error = json["error"];
      return SetPinResponseModel(
        success: false,
        status: error?["status"],
        errorMessage: error?["message"],
        errorCode: error?["code"],
      );
    }
  }

  SetPinResponseEntity toEntity() {
    return SetPinResponseEntity(
      success: success,
      message: message,
      status: status,
      errorMessage: errorMessage,
      errorCode: errorCode,
      onboarded: onboarded,
    );
  }
}
