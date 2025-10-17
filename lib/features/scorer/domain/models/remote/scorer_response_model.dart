import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_response_entity.dart';

class ScorerResponseModel {
  final bool success;
  final MatchCenterEntity? matchCenterEntity;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  ScorerResponseModel({
    required this.success,
    this.matchCenterEntity,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  factory ScorerResponseModel.fromJson(Map<String, dynamic> json) {
    return ScorerResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String?,
      status: json['status'] as int?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  ScorerResponseEntity toEntity() {
    return ScorerResponseEntity(
      success: success,
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }
}
