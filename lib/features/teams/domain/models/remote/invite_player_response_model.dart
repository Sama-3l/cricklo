// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/invite_player_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/invite_model.dart';

class InvitePlayerResponseModel {
  final bool success;
  final List<InviteModel>? invites;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  InvitePlayerResponseModel({
    required this.success,
    this.invites,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'invites': invites != null
          ? invites!.map((x) => x.toJson()).toList()
          : [],
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  factory InvitePlayerResponseModel.fromJson(Map<String, dynamic> map) {
    return InvitePlayerResponseModel(
      success: map['success'] as bool,
      invites: map['invites'] != null
          ? List<InviteModel>.from(
              (map['invites'] as List<int>).map<InviteModel?>(
                (x) => InviteModel.fromJson(x as Map<String, dynamic>),
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

  InvitePlayerResponseEntity toEntity() {
    return InvitePlayerResponseEntity(
      success: success,
      invites: invites?.map((e) => e.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }
}
