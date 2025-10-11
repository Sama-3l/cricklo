// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/account/domain/entities/get_teams_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';

class GetTeamsResponseModel {
  final bool success;
  final List<TeamModel>? teams;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetTeamsResponseModel({
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

  GetTeamsResponseEntity toEntity() {
    return GetTeamsResponseEntity(
      success: success,
      teams: teams?.map((x) => x.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory GetTeamsResponseModel.fromJson(Map<String, dynamic> map) {
    // users: List<SearchUserModel>.from(
    //     (map['players'] as List<dynamic>).map<SearchUserModel>(
    //       (x) => SearchUserModel.fromJson(x),
    //     ),
    //   ),
    return GetTeamsResponseModel(
      success: map['success'] as bool,
      teams: map['data'] != null
          ? List<TeamModel>.from(
              (map['data'] as List<dynamic>).map<TeamModel?>(
                (x) => TeamModel.fromJson(x as Map<String, dynamic>),
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
