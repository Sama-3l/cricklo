import 'package:cricklo/features/teams/domain/entities/create_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';

class CreateTeamResponseModel {
  final bool success;
  final TeamModel? teamModel;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  CreateTeamResponseModel({
    required this.success,
    this.teamModel,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'team': teamModel?.toJson(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  factory CreateTeamResponseModel.fromJson(Map<String, dynamic> map) {
    return CreateTeamResponseModel(
      success: map['success'] as bool,
      teamModel: map['data'] != null ? TeamModel.fromJson(map['data']) : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }

  CreateTeamResponseEntity toEntity() {
    return CreateTeamResponseEntity(
      success: success,
      team: teamModel?.toEntity(),
      message: message,
      status: status,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }
}
