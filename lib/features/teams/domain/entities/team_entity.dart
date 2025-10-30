// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/teams/domain/entities/partnership_stats_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_points_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_stats_entities.dart';
import 'package:cricklo/features/teams/domain/entities/team_stats_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';

class TeamEntity {
  final String? uuid;
  final String id;
  final String? inviteStatus;
  final String name;
  final File? logoFile;
  final File? bannerFile;
  final String teamLogo;
  final String teamBanner;
  int followers;
  bool userFollows;
  final List<PlayerEntity> players;
  final LocationEntity location;
  final TeamStatsEntity? teamStatsEntity;
  final List<TeamBattingStatsEntity> battingStats;
  final List<TeamBowlingStatsEntity> bowlingStats;
  final List<TeamFieldingStatsEntity> fieldingStats;
  final List<MatchEntity> matches;
  final List<TournamentEntity> tournaments;
  final List<PlayerPointsEntity> pointsStats;
  final List<PartnershipStatsEntity> partnershipStats;

  TeamEntity({
    required this.uuid,
    required this.id,
    required this.name,
    required this.inviteStatus,
    this.logoFile,
    this.bannerFile,
    required this.userFollows,
    required this.teamLogo,
    required this.followers,
    required this.teamBanner,
    required this.players,
    required this.location,
    this.teamStatsEntity,
    required this.battingStats,
    required this.bowlingStats,
    required this.fieldingStats,
    required this.matches,
    required this.tournaments,
    required this.pointsStats,

    required this.partnershipStats,
  });

  TeamEntity copyWith({
    String? uuid,
    String? id,
    String? inviteStatus,
    String? name,
    File? logoFile,
    File? bannerFile,
    int? followers,
    bool? userFollows,
    String? teamLogo,
    String? teamBanner,
    List<PlayerEntity>? players,
    LocationEntity? location,
    TeamStatsEntity? teamStatsEntity,
    List<TeamBattingStatsEntity>? battingStats,
    List<TeamBowlingStatsEntity>? bowlingStats,
    List<TeamFieldingStatsEntity>? fieldingStats,
    List<MatchEntity>? matches,
    List<TournamentEntity>? tournaments,
    List<PlayerPointsEntity>? pointsStats,

    List<PartnershipStatsEntity>? partnershipStats,
  }) {
    return TeamEntity(
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      inviteStatus: inviteStatus ?? this.inviteStatus,
      followers: followers ?? this.followers,
      name: name ?? this.name,
      logoFile: logoFile ?? this.logoFile,
      userFollows: userFollows ?? this.userFollows,
      bannerFile: bannerFile ?? this.bannerFile,
      teamLogo: teamLogo ?? this.teamLogo,
      teamBanner: teamBanner ?? this.teamBanner,
      players: players ?? this.players,
      location: location ?? this.location,
      teamStatsEntity: teamStatsEntity ?? this.teamStatsEntity,
      battingStats: battingStats ?? this.battingStats,
      bowlingStats: bowlingStats ?? this.bowlingStats,
      fieldingStats: fieldingStats ?? this.fieldingStats,
      matches: matches ?? this.matches,
      tournaments: tournaments ?? this.tournaments,
      pointsStats: pointsStats ?? this.pointsStats,
      partnershipStats: partnershipStats ?? this.partnershipStats,
    );
  }
}
