import 'package:cricklo/features/follow/domain/entities/follow_response_entity.dart';

class FollowResponseModel {
  final bool success;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  FollowResponseModel({
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

  FollowResponseEntity toEntity() {
    return FollowResponseEntity(
      success: success,
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory FollowResponseModel.fromJson(Map<String, dynamic> map) {
    return FollowResponseModel(
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
