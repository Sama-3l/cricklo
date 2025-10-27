// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/notifications/domain/entities/get_notifications_response_entity.dart';
import 'package:cricklo/features/notifications/domain/models/remote/match_notification_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/team_notification_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/tournament_notification_model.dart';

class GetNotificationsResponseModel {
  final bool success;
  final int count;
  final List<TeamNotificationModel> teamNotifications;
  final List<MatchNotificationModel> matchNotifications;
  final List<TournamentNotificationModel> tournamentNotifications;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetNotificationsResponseModel({
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
      matchNotifications: matchNotifications.map((e) => e.toEntity()).toList(),
      teamNotifications: teamNotifications.map((e) => e.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
      tournamentNotifications: tournamentNotifications
          .map((e) => e.toEntity())
          .toList(),
    );
  }

  factory GetNotificationsResponseModel.fromJson(Map<String, dynamic> map) {
    List<TeamNotificationModel> teamNotifications = [];
    List<MatchNotificationModel> matchNotifications = [];
    List<TournamentNotificationModel> tournamentNotifications = [];
    for (var notify in map['data'] as List<dynamic>) {
      if (notify["type"] == "TEAM_INVITE") {
        teamNotifications.add(TeamNotificationModel.fromJson(notify));
      }
      if (notify["type"] == "MATCH_INVITE" ||
          notify["type"] == "MATCH_SCORER_INVITE") {
        matchNotifications.add(
          MatchNotificationModel.fromJson(
            notify["enriched"],
            notify["type"] == "MATCH_INVITE"
                ? NotificationType.match
                : NotificationType.scorer,
            notify["inviteId"],
          ),
        );
      }
      if (notify["type"] == "TOURNAMENT_MODERATOR_INVITE" ||
          notify["type"] == "INVITE_TEAMS_TO_TOURNAMENT") {
        tournamentNotifications.add(
          TournamentNotificationModel.fromJson(
            notify,
            notify["type"] == "TOURNAMENT_MODERATOR_INVITE"
                ? NotificationType.tournamentModerator
                : NotificationType.tournamentTeam,
          ),
        );
      }
    }
    return GetNotificationsResponseModel(
      success: map['success'] as bool,
      count: map['count'] as int? ?? 0,
      teamNotifications: teamNotifications,
      matchNotifications: matchNotifications,
      tournamentNotifications: tournamentNotifications,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}
