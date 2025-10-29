import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/partnership_stats_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/player_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/player_stats_models.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_stats_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';

class TeamModel {
  final String? uuid;
  final String id;
  final String name;
  final String? inviteStatus;
  final String teamLogo;
  final int followers;
  bool userFollows;
  final String teamBanner;
  final List<PlayerModel> players;
  final LocationModel location;
  final TeamStatsModel? teamStatsModel;
  final List<TeamBattingStatsModel> battingStats;
  final List<TeamBowlingStatsModel> bowlingStats;
  final List<TeamFieldingStatsModel> fieldingStats;
  final List<MatchModel> matches;
  final List<TournamentModel> tournaments;
  final List<PartnershipStatsModel> partnershipStats;

  TeamModel({
    required this.uuid,
    required this.id,
    required this.name,
    required this.teamLogo,
    required this.followers,
    required this.userFollows,
    required this.inviteStatus,
    required this.teamBanner,
    this.players = const [],
    required this.location,
    this.teamStatsModel,
    required this.battingStats,
    required this.bowlingStats,
    required this.fieldingStats,
    required this.matches,
    required this.tournaments,
    required this.partnershipStats,
  });

  TeamModel copyWith({
    String? uuid,
    String? id,
    String? name,
    String? teamLogo,
    int? followers,
    String? teamBanner,
    bool? userFollows,
    String? inviteStatus,
    List<PlayerModel>? players,
    LocationModel? location,
    TeamStatsModel? teamStatsModel,
    List<TeamBattingStatsModel>? battingStats,
    List<TeamBowlingStatsModel>? bowlingStats,
    List<TeamFieldingStatsModel>? fieldingStats,
    List<MatchModel>? matches,
    List<TournamentModel>? tournaments,
    List<PartnershipStatsModel>? partnershipStats,
  }) {
    return TeamModel(
      inviteStatus: inviteStatus ?? this.inviteStatus,
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      name: name ?? this.name,
      teamLogo: teamLogo ?? this.teamLogo,
      userFollows: userFollows ?? this.userFollows,
      followers: followers ?? this.followers,
      teamBanner: teamBanner ?? this.teamBanner,
      players: players ?? this.players,
      location: location ?? this.location,
      teamStatsModel: teamStatsModel ?? this.teamStatsModel,
      battingStats: battingStats ?? this.battingStats,
      bowlingStats: bowlingStats ?? this.bowlingStats,
      fieldingStats: fieldingStats ?? this.fieldingStats,
      matches: matches ?? this.matches,
      tournaments: tournaments ?? this.tournaments,
      partnershipStats: partnershipStats ?? this.partnershipStats,
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
      userFollows: team.userFollows,
      inviteStatus: team.inviteStatus,
      uuid: team.uuid,
      id: team.id,
      name: team.name,
      teamLogo: team.teamLogo,
      teamBanner: team.teamBanner,
      followers: team.followers,
      location: LocationModel.fromEntity(team.location),
      teamStatsModel: team.teamStatsEntity != null
          ? TeamStatsModel.fromEntity(team.teamStatsEntity!)
          : null,
      battingStats: team.battingStats
          .map((e) => TeamBattingStatsModel.fromEntity(e))
          .toList(),
      bowlingStats: team.bowlingStats
          .map((e) => TeamBowlingStatsModel.fromEntity(e))
          .toList(),
      fieldingStats: team.fieldingStats
          .map((e) => TeamFieldingStatsModel.fromEntity(e))
          .toList(),
      matches: team.matches.map((e) => MatchModel.fromEntity(e)).toList(),
      tournaments: team.tournaments
          .map((e) => TournamentModel.fromEntity(e))
          .toList(),
      partnershipStats: team.partnershipStats
          .map((e) => PartnershipStatsModel.fromEntity(e))
          .toList(),
    );
  }

  factory TeamModel.fromJson(Map<String, dynamic> map) {
    final players = map['teamPlayers'] != null
        ? (map['teamPlayers'] as List<dynamic>)
              .map<PlayerModel>((e) => PlayerModel.fromJson(e))
              .toList()
        : map['players'] != null
        ? (map['players'] as List<dynamic>)
              .map<PlayerModel>((e) => PlayerModel.fromJson(e))
              .toList()
        : <PlayerModel>[];
    return TeamModel(
      inviteStatus: map['inviteStatus'] as String?,
      uuid: map['id'] as String?,
      id: map['teamId'] as String,
      userFollows: map['follows'] as bool? ?? false,
      name: map['name'] ?? map['teamName'] as String,
      teamLogo: map['logo'] ?? map['teamLogo'] as String,
      teamBanner: map['banner'] ?? map['teamBanner'] as String? ?? "",
      players: players,
      location: map.containsKey('location')
          ? map['location'] == null
                ? LocationModel(area: "", city: "", state: "", lat: 0, lng: 0)
                : LocationModel.fromJson(
                    map['location'] as Map<String, dynamic>,
                  )
          : map['city'] == null
          ? LocationModel(area: "", city: "", state: "", lat: 0, lng: 0)
          : LocationModel.fromJson({
              'city': map['city'],
              'state': map['state'],
            }),
      followers: map['followersCount'] as int? ?? 0,
      teamStatsModel: map['teamStats'] == null
          ? null
          : TeamStatsModel.fromJson(map['teamStats'] as Map<String, dynamic>),
      battingStats: map["playerStats"] == null
          ? []
          : (map["playerStats"]["batting"] as List<dynamic>)
                .map((e) => TeamBattingStatsModel.fromJson(e, players))
                .toList(),
      bowlingStats: map["playerStats"] == null
          ? []
          : (map["playerStats"]["bowling"] as List<dynamic>)
                .map((e) => TeamBowlingStatsModel.fromJson(e, players))
                .toList(),
      fieldingStats: map["playerStats"] == null
          ? []
          : (map["playerStats"]["fielding"] as List<dynamic>)
                .map((e) => TeamFieldingStatsModel.fromJson(e, players))
                .toList(),
      matches: map["matches"] == null
          ? []
          : (map["matches"] as List<dynamic>)
                .map((e) => MatchModel.fromJson(e))
                .toList(),
      tournaments: map["tournaments"] == null
          ? []
          : (map["tournaments"] as List<dynamic>)
                .map((e) => TournamentModel.fromJson(e))
                .toList(),
      partnershipStats: map["partnerships"] == null
          ? []
          : (map["partnerships"] as List<dynamic>)
                .map((e) => PartnershipStatsModel.fromJson(e))
                .toList(),
    );
  }

  TeamEntity toEntity() {
    return TeamEntity(
      inviteStatus: inviteStatus,
      userFollows: userFollows,
      uuid: uuid,
      id: id,
      name: name,
      teamLogo: teamLogo,
      teamBanner: teamBanner,
      players: players.map((e) => e.toEntity()).toList(),
      location: location.toEntity(),
      followers: followers,
      teamStatsEntity: teamStatsModel?.toEntity(),
      battingStats: battingStats.map((e) => e.toEntity()).toList(),
      bowlingStats: bowlingStats.map((e) => e.toEntity()).toList(),
      fieldingStats: fieldingStats.map((e) => e.toEntity()).toList(),
      matches: matches.map((e) => e.toEntity()).toList(),
      tournaments: tournaments.map((e) => e.toEntity()).toList(),
      partnershipStats: partnershipStats.map((e) => e.toEntity()).toList(),
    );
  }
}
