// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/search_team_player_entity.dart';

class SearchTeamPlayerModel {
  final String playerId;
  final String name;
  final String? logo;
  final bool captain;
  final TeamRole teamRole;

  SearchTeamPlayerModel({
    required this.playerId,
    required this.name,
    required this.captain,
    required this.logo,
    required this.teamRole,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'playerId': playerId,
      'name': name,
      'captain': captain,
      'logo': logo,
      'teamRole': teamRole.roleTitle,
    };
  }

  SearchTeamPlayerEntity toEntity() {
    return SearchTeamPlayerEntity(
      playerId: playerId,
      name: name,
      captain: captain,
      teamRole: teamRole,
      logo: logo,
    );
  }

  factory SearchTeamPlayerModel.fromJson(Map<String, dynamic> map) {
    TeamRole teamRole;
    switch (map['teamRole'] as String) {
      case "Active":
        teamRole = TeamRole.active;
        break;
      case "Member":
        teamRole = TeamRole.member;
        break;
      case "Invited":
        teamRole = TeamRole.invited;
        break;
      case "Captain":
        teamRole = TeamRole.captain;
        break;
      case "Sub":
        teamRole = TeamRole.sub;
        break;
      default:
        teamRole = TeamRole.invited;
        break;
    }
    return SearchTeamPlayerModel(
      playerId: map['playerId'] as String,
      name: map['playerName'] as String,
      captain: teamRole == TeamRole.captain,
      teamRole: teamRole,
      logo: map['profilePic'] as String?,
    );
  }
}
