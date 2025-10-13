// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/match_notification_team_entity.dart';

class MatchNotificationEntity {
  final String matchId;
  final NotificationType notificationType;
  final MatchNotificationTeamEntity teamA;
  final MatchNotificationTeamEntity teamB;
  final LocationEntity locationEntity;
  final DateTime dateTime;
  final MatchType format;
  final int overs;

  MatchNotificationEntity({
    required this.matchId,
    required this.notificationType,
    required this.teamA,
    required this.teamB,
    required this.locationEntity,
    required this.dateTime,
    required this.format,
    required this.overs,
  });
}
