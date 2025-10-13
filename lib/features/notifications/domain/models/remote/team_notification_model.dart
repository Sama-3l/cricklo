import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/notifications/domain/entities/team_notification_entity.dart';

class TeamNotificationModel {
  final String id;
  final NotificationType notificationType;
  final String teamName;
  final String message;
  final String inviteId;
  final String senderProfileId;
  final String teamId;

  TeamNotificationModel({
    required this.id,
    required this.notificationType,
    required this.teamName,
    required this.message,
    required this.inviteId,
    required this.senderProfileId,
    required this.teamId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'notificationType': notificationType.name,
      'teamName': teamName,
      'message': message,
      'inviteId': inviteId,
      'senderProfileId': senderProfileId,
      'teamId': teamId,
    };
  }

  TeamNotificationEntity toEntity() {
    return TeamNotificationEntity(
      id: id,
      notificationType: notificationType,
      teamName: teamName,
      message: message,
      inviteId: inviteId,
      senderProfileId: senderProfileId,
      teamId: teamId,
    );
  }

  factory TeamNotificationModel.fromJson(Map<String, dynamic> map) {
    return TeamNotificationModel(
      id: map['id'] as String,
      notificationType: NotificationType.team,
      teamName: map["enriched"]["team"]["name"],
      message: map['message'] as String,
      inviteId: map['inviteId'] as String,
      senderProfileId: map['senderProfileId'] as String,
      teamId: map["enriched"]["recordId"] as String,
    );
  }
}
