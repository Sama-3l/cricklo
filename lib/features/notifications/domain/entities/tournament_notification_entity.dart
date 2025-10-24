// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class TournamentNotificationEntity {
  final String id;
  final NotificationType notificationType;
  final String tournamentName;
  final String message;
  final String inviteId;
  final String senderProfileId;
  final String tournamentId;

  TournamentNotificationEntity({
    required this.id,
    required this.notificationType,
    required this.tournamentName,
    required this.message,
    required this.inviteId,
    required this.senderProfileId,
    required this.tournamentId,
  });
}
