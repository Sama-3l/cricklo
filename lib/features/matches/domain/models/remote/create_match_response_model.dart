import 'package:cricklo/features/matches/domain/entities/create_match_response_entity.dart';

class CreateMatchResponseModel {
  final bool success;
  final String matchId;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  CreateMatchResponseModel({
    required this.success,
    required this.matchId,
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

  CreateMatchResponseEntity toEntity() {
    return CreateMatchResponseEntity(
      matchId: matchId,
      success: success,
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory CreateMatchResponseModel.fromJson(Map<String, dynamic> map) {
    return CreateMatchResponseModel(
      success: map['success'] as bool,
      matchId: map['data']['matchId'] as String,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
