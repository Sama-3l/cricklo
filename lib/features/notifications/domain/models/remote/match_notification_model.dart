import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/notifications/domain/entities/match_notification_entity.dart';
import 'package:cricklo/features/notifications/domain/models/remote/match_notification_team_model.dart';

class MatchNotificationModel {
  final String inviteId;
  final String matchId;
  final NotificationType notificationType;
  final MatchNotificationTeamModel teamA;
  final MatchNotificationTeamModel teamB;
  final LocationModel locationEntity;
  final DateTime dateTime;
  final MatchType format;
  final int overs;

  MatchNotificationModel({
    required this.inviteId,
    required this.matchId,
    required this.notificationType,
    required this.teamA,
    required this.teamB,
    required this.locationEntity,
    required this.dateTime,
    required this.format,
    required this.overs,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'matchId': matchId,
      'notificationType': notificationType.name,
      'teamA': teamA.toJson(),
      'teamB': teamB.toJson(),
      'locationEntity': locationEntity.toJson(),
      'dateTime': dateTime.millisecondsSinceEpoch,
      'format': format.matchType,
      'overs': overs,
      'inviteId': inviteId,
    };
  }

  MatchNotificationEntity toEntity() {
    return MatchNotificationEntity(
      matchId: matchId,
      notificationType: notificationType,
      teamA: teamA.toEntity(),
      teamB: teamB.toEntity(),
      locationEntity: locationEntity.toEntity(),
      dateTime: dateTime,
      format: format,
      overs: overs,
      inviteId: inviteId,
    );
  }

  factory MatchNotificationModel.fromJson(
    Map<String, dynamic> map,
    NotificationType notifcationType,
    String inviteId,
  ) {
    MatchType matchType = MatchType.t10;
    final format = map["format"] as String?;
    if (format != null) {
      switch (format) {
        case "T10":
          matchType = MatchType.t10;
          break;
        case "T20":
          matchType = MatchType.t20;
          break;
        case "T30":
          matchType = MatchType.t30;
          break;
        case "ODI":
          matchType = MatchType.odi;
          break;
        case "Test":
          matchType = MatchType.test;
          break;
        default:
          matchType = MatchType.t20;
          break;
      }
    }
    final utcTime = DateTime.parse(map['timeAndDate'] as String);
    final dateAndTime = DateTime(
      utcTime.year,
      utcTime.month,
      utcTime.day,
      utcTime.hour,
      utcTime.minute,
      utcTime.second,
    );
    print(inviteId);
    print(map['recordId'] as String);
    print(notifcationType);
    print(
      MatchNotificationTeamModel.fromJson(map['teamA'] as Map<String, dynamic>),
    );
    print(
      MatchNotificationTeamModel.fromJson(map['teamB'] as Map<String, dynamic>),
    );
    print(LocationModel.fromJson(map['location'] as Map<String, dynamic>));
    print(dateAndTime);
    print(matchType);
    print(map['overs'] as int);
    return MatchNotificationModel(
      inviteId: inviteId,
      matchId: map['recordId'] as String,
      notificationType: notifcationType,
      teamA: MatchNotificationTeamModel.fromJson(
        map['teamA'] as Map<String, dynamic>,
      ),
      teamB: MatchNotificationTeamModel.fromJson(
        map['teamB'] as Map<String, dynamic>,
      ),
      locationEntity: LocationModel.fromJson(
        map['location'] as Map<String, dynamic>,
      ),
      dateTime: dateAndTime,
      format: matchType,
      overs: map['overs'] as int,
    );
  }
}
