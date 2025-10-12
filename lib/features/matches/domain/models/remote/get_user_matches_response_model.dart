import 'package:cricklo/features/matches/domain/entities/get_user_matches_response_entity.dart';
import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';

class GetUserMatchesResponseModel {
  final bool success;
  final List<MatchModel> matches;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetUserMatchesResponseModel({
    required this.success,
    required this.matches,
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

  GetUserMatchesResponseEntity toEntity() {
    return GetUserMatchesResponseEntity(
      matches: matches.map((e) => e.toEntity()).toList(),
      success: success,
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory GetUserMatchesResponseModel.fromJson(Map<String, dynamic> map) {
    return GetUserMatchesResponseModel(
      success: map['success'] as bool,
      matches: (map['data'] as List<dynamic>)
          .map<MatchModel>((e) => MatchModel.fromJson(e))
          .toList(),
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
