// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cricklo/features/notifications/domain/entities/get_notifications_response_entity.dart';
import 'package:cricklo/features/notifications/domain/models/remote/team_notification_model.dart';

class GetNotificationsResponseModel {
  final bool success;
  final int count;
  final List<TeamNotificationModel> teamNotifications;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetNotificationsResponseModel({
    required this.success,
    required this.count,
    required this.teamNotifications,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'count': count,
      'teamNotifications': teamNotifications.map((x) => x.toJson()).toList(),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  GetNotificationsResponseEntity toEntity() {
    return GetNotificationsResponseEntity(
      success: success,
      count: count,
      teamNotifications: teamNotifications.map((e) => e.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory GetNotificationsResponseModel.fromJson(Map<String, dynamic> map) {
    List<TeamNotificationModel> teamNotifications = [];
    for (var notify in map['data'] as List<dynamic>) {
      if (notify["type"] == "TEAM_INVITE") {
        teamNotifications.add(TeamNotificationModel.fromJson(notify));
      }
    }
    return GetNotificationsResponseModel(
      success: map['success'] as bool,
      count: map['count'] as int? ?? 0,
      teamNotifications: teamNotifications,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
