import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';

class InviteResponseResponseModel {
  final bool success;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  InviteResponseResponseModel({
    required this.success,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  InviteResponseResponseEntity toEntity() {
    return InviteResponseResponseEntity(
      success: success,
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory InviteResponseResponseModel.fromJson(Map<String, dynamic> map) {
    return InviteResponseResponseModel(
      success: map['success'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
