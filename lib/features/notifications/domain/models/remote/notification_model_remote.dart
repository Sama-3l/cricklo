// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cricklo/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final String teamId;
  final String inviteId;
  final String message;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.teamId,
    required this.inviteId,
    required this.message,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'teamId': teamId,
      'inviteId': inviteId,
      'message': message,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      teamId: map['teamId'] as String,
      inviteId: map['inviteId'] as String,
      message: map['message'] as String,
      isRead: map['isRead'] as bool,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      teamId: teamId,
      inviteId: inviteId,
      message: message,
      isRead: isRead,
    );
  }
}
