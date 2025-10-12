// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cricklo/features/teams/domain/entities/search_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';

class SearchTeamResponseModel {
  final bool success;
  final List<TeamModel>? teams;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  SearchTeamResponseModel({
    required this.success,
    this.teams,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'teams': teams?.map((x) => x.toJson()).toList(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  SearchTeamResponseEntity toEntity() {
    return SearchTeamResponseEntity(
      success: success,
      teams: teams!.map((e) => e.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory SearchTeamResponseModel.fromJson(Map<String, dynamic> map) {
    return SearchTeamResponseModel(
      success: map['success'] as bool,
      teams: map['data'] != null
          ? List<TeamModel>.from(
              (map['data'] as List<dynamic>).map<TeamModel>(
                (x) => TeamModel.fromJson(x),
              ),
            )
          : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
