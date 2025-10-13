// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class TeamNotificationEntity {
  final String id;
  final NotificationType notificationType;
  final String teamName;
  final String message;
  final String inviteId;
  final String senderProfileId;
  final String teamId;

  TeamNotificationEntity({
    required this.id,
    required this.notificationType,
    required this.teamName,
    required this.message,
    required this.inviteId,
    required this.senderProfileId,
    required this.teamId,
  });
}
