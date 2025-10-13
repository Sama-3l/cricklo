import 'package:cricklo/features/notifications/domain/entities/match_notification_team_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MatchNotificationTeamModel {
  final String name;
  final String teamId;
  final String logo;
  final bool isCurrentUserTeam;

  MatchNotificationTeamModel({
    required this.name,
    required this.teamId,
    required this.logo,
    required this.isCurrentUserTeam,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'teamId': teamId,
      'logo': logo,
      'isCurrentUserTeam': isCurrentUserTeam,
    };
  }

  MatchNotificationTeamEntity toEntity() {
    return MatchNotificationTeamEntity(
      name: name,
      teamId: teamId,
      logo: logo,
      isCurrentUserTeam: isCurrentUserTeam,
    );
  }

  factory MatchNotificationTeamModel.fromJson(Map<String, dynamic> map) {
    return MatchNotificationTeamModel(
      name: map['name'] as String,
      teamId: map['id'] as String,
      logo: map['logo'] as String,
      isCurrentUserTeam: map['isCurrentUserTeam'] as bool,
    );
  }
}
