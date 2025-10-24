// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cricklo/features/notifications/domain/entities/match_notification_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/team_notification_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/tournament_notification_entity.dart';

class GetNotificationsResponseEntity {
  final bool success;
  final int count;
  final List<TeamNotificationEntity> teamNotifications;
  final List<MatchNotificationEntity> matchNotifications;
  final List<TournamentNotificationEntity> tournamentNotifications;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetNotificationsResponseEntity({
    required this.success,
    required this.count,
    required this.teamNotifications,
    required this.matchNotifications,
    required this.tournamentNotifications,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
