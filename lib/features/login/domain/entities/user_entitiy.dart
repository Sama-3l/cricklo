// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/account/domain/entities/matchwise_stats_entity.dart';
import 'package:cricklo/features/account/domain/entities/player_stats_entity.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';

class UserEntity {
  final String profileId;
  final String name;
  final String email;
  final int unreadNotifications;
  final File? profilePicFile;
  final String? profilePic;
  final String phoneNumber;
  final String countryCode;
  final LocationEntity location;
  int followers;
  final int following;
  bool userFollow;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final List<MatchEntity> userMatches;
  final List<TournamentEntity> tournaments;
  final AccountStatsEntity? accountStats;
  final List<MatchWiseStatsEntity> matchwiseStats;

  UserEntity({
    required this.profileId,
    this.playerType = PlayerType.batter,
    this.batterType,
    this.bowlerType,
    this.profilePicFile,
    required this.unreadNotifications,
    required this.profilePic,
    required this.phoneNumber,
    this.countryCode = "+91",
    required this.userFollow,
    required this.name,
    required this.email,
    required this.location,
    required this.followers,
    required this.following,
    required this.userMatches,
    required this.tournaments,
    this.accountStats, // 🆕
    required this.matchwiseStats,
  });

  UserEntity copyWith({
    String? profileId,
    String? name,
    String? email,
    int? unreadNotifications,
    File? profilePicFile,
    String? profilePic,
    String? phoneNumber,
    String? countryCode,
    LocationEntity? location,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
    int? followers,
    bool? userFollow,
    int? following,
    List<MatchEntity>? userMatches,
    List<TournamentEntity>? tournaments,
    final AccountStatsEntity? accountStats,
    List<MatchWiseStatsEntity>? matchwiseStats,
  }) {
    return UserEntity(
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      email: email ?? this.email,
      userFollow: userFollow ?? this.userFollow,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      profilePic: profilePic ?? this.profilePic,
      profilePicFile: profilePicFile ?? this.profilePicFile,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      location: location ?? this.location,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      userMatches: userMatches ?? this.userMatches,
      tournaments: tournaments ?? this.tournaments,
      accountStats: accountStats ?? this.accountStats,
      matchwiseStats: matchwiseStats ?? this.matchwiseStats,
    );
  }
}
