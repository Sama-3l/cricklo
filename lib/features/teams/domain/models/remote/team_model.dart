import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/player_model.dart';

class TeamModel {
  final String? uuid;
  final String id;
  final String name;
  final String? inviteStatus;
  final String teamLogo;
  final int followers;
  final String teamBanner;
  final List<PlayerModel> players;
  final LocationModel location;

  TeamModel({
    required this.uuid,
    required this.id,
    required this.name,
    required this.teamLogo,
    required this.followers,
    required this.inviteStatus,
    required this.teamBanner,
    this.players = const [],
    required this.location,
  });

  TeamModel copyWith({
    String? uuid,
    String? id,
    String? name,
    String? teamLogo,
    int? followers,
    String? teamBanner,
    String? inviteStatus,
    List<PlayerModel>? players,
    LocationModel? location,
  }) {
    return TeamModel(
      inviteStatus: inviteStatus ?? this.inviteStatus,
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      name: name ?? this.name,
      teamLogo: teamLogo ?? this.teamLogo,
      followers: followers ?? this.followers,
      teamBanner: teamBanner ?? this.teamBanner,
      players: players ?? this.players,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'logo': teamLogo,
      'banner': teamBanner,
      'location': location.toJson(),
      'followers': followers,
    };
  }

  factory TeamModel.fromEntity(TeamEntity team) {
    return TeamModel(
      inviteStatus: team.inviteStatus,
      uuid: team.uuid,
      id: team.id,
      name: team.name,
      teamLogo: team.teamLogo,
      teamBanner: team.teamBanner,
      followers: team.followers,
      location: LocationModel.fromEntity(team.location),
    );
  }

  factory TeamModel.fromJson(Map<String, dynamic> map) {
    return TeamModel(
      inviteStatus: map['inviteStatus'] as String?,
      uuid: map['id'] as String?,
      id: map['teamId'] as String,
      name: map['name'] ?? map['teamName'] as String,
      teamLogo: map['logo'] ?? map['teamLogo'] as String,
      teamBanner: map['banner'] ?? map['teamBanner'] as String,
      players: map['teamPlayers'] != null
          ? (map['teamPlayers'] as List<dynamic>)
                .map<PlayerModel>((e) => PlayerModel.fromJson(e))
                .toList()
          : map['players'] != null
          ? (map['players'] as List<dynamic>)
                .map<PlayerModel>((e) => PlayerModel.fromJson(e))
                .toList()
          : [],
      location: map.containsKey('location')
          ? LocationModel.fromJson(map['location'] as Map<String, dynamic>)
          : LocationModel.fromJson({
              'city': map['city'],
              'state': map['state'],
            }),
      followers: map['followersCount'] as int? ?? 0,
    );
  }

  TeamEntity toEntity() {
    return TeamEntity(
      inviteStatus: inviteStatus,
      uuid: uuid,
      id: id,
      name: name,
      teamLogo: teamLogo,
      teamBanner: teamBanner,
      players: players.map((e) => e.toEntity()).toList(),
      location: location.toEntity(),
      followers: followers,
    );
  }
}
