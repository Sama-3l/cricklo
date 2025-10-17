import 'package:cricklo/features/scorer/domain/entities/get_match_state_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_center_model.dart';

class GetMatchStateResponseModel {
  final bool success;
  final String? message;
  final MatchCenterModel? match;
  final bool? live;
  final String? source;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetMatchStateResponseModel({
    required this.success,
    this.message,
    this.match,
    this.live,
    this.source,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  factory GetMatchStateResponseModel.fromJson(Map<String, dynamic> map) {
    final data = map['data'];
    return GetMatchStateResponseModel(
      success: map['success'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      match: data?['match'] != null
          ? MatchCenterModel.fromJson(data['match'])
          : null,
      live: data?['live'] as bool?,
      source: data?['source'] as String?,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {'match': match?.toJson(), 'live': live, 'source': source},
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  GetMatchStateResponseEntity toEntity() {
    return GetMatchStateResponseEntity(
      success: success,
      message: message,
      match: match?.toEntity(),
      live: live,
      source: source,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }
}
