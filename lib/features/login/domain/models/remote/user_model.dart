// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/account/domain/models/remote/matchwise_stats_model.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/account/domain/models/remote/account_stats_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_model.dart';

class UserModel {
  final String profileId;
  final String name;
  final String? profilePic;
  final int unreadNotifications;
  final String email;
  final bool userFollow;
  final String? phoneNumber;
  final String? countryCode;
  final LocationEntity location;
  final int followers;
  final int following;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final List<MatchModel> userMatches;
  final List<TournamentModel> tournaments;
  final AccountStatsModel? accountStats;
  final List<MatchWiseStatsModel> matchwiseStats;

  UserModel({
    required this.profileId,
    required this.unreadNotifications,
    required this.name,
    required this.email,
    required this.userFollow,
    required this.profilePic,
    this.phoneNumber,
    this.countryCode = "+91",
    required this.location,
    required this.followers,
    required this.following,
    this.playerType = PlayerType.batter,
    this.batterType,
    this.bowlerType,
    required this.userMatches,
    required this.tournaments,
    this.accountStats,
    required this.matchwiseStats,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      profilePic: entity.profilePic,
      profileId: entity.profileId,
      unreadNotifications: entity.unreadNotifications,
      name: entity.name,
      email: entity.email,
      userFollow: entity.userFollow,
      phoneNumber: entity.phoneNumber,
      countryCode: entity.countryCode,
      location: entity.location,
      playerType: entity.playerType,
      batterType: entity.batterType,
      bowlerType: entity.bowlerType,
      followers: entity.followers,
      following: entity.following,
      userMatches: entity.userMatches
          .map((e) => MatchModel.fromEntity(e))
          .toList(),
      tournaments: entity.tournaments
          .map((e) => TournamentModel.fromEntity(e))
          .toList(),
      matchwiseStats: entity.matchwiseStats
          .map((e) => MatchWiseStatsModel.fromEntity(e))
          .toList(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    // Location (API currently returns just an ID)
    final location = LocationEntity(
      area: '', // no area info from API
      city: '',
      state: '',
      lat: 0,
      lng: 0,
    );

    // PlayerType
    PlayerType playerType;
    switch ((data['Player_Type'] ?? '').toString().toLowerCase()) {
      case 'batsman':
        playerType = PlayerType.batter;
        break;
      case 'bowler':
        playerType = PlayerType.bowler;
        break;
      case 'allrounder':
      default:
        playerType = PlayerType.allRounder;
    }

    // BatterType
    BatterType? batterType;
    final batsmen = data['Batsmen'] as List<dynamic>? ?? [];
    if (batsmen.isNotEmpty) {
      final typeStr = batsmen[0]['Batsman_Type'] ?? '';
      switch (typeStr.toUpperCase()) {
        case 'LEFT_HANDED':
          batterType = BatterType.leftHand;
          break;
        case 'RIGHT_HANDED':
          batterType = BatterType.rightHand;
          break;
      }
    }

    // BowlerType
    BowlerType? bowlerType;
    final bowlers = data['Bowlers'] as List<dynamic>? ?? [];
    if (bowlers.isNotEmpty) {
      final typeStr = bowlers[0]['Bowler_Type'] ?? '';
      switch (typeStr.toUpperCase()) {
        case 'LEFT_ARM_LEGSPIN':
          bowlerType = BowlerType.leftArmSpin;
          break;
        case 'LEFT_ARM_FAST':
          bowlerType = BowlerType.leftArmPace;
          break;
        case 'RIGHT_ARM_LEGSPIN':
          bowlerType = BowlerType.rightArmSpin;
          break;
        case 'RIGHT_ARM_FAST':
          bowlerType = BowlerType.rightArmPace;
          break;
        default:
          bowlerType = BowlerType.leftArmSpin;
      }
    }
    return UserModel(
      unreadNotifications: data["unreadNotifications"] as int? ?? 0,
      profilePic: data['Profile_Photo'],
      profileId: data['profileId'],
      name: data['Name'] ?? '',
      email: data['Email'] ?? '',
      location: location,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      userFollow: data['follows'] as bool? ?? false,
      followers: data['followersCount'] as int? ?? 0,
      following: data['followingCount'] as int? ?? 0,
      userMatches: (data['matches'] as List<dynamic>)
          .map((e) => MatchModel.fromJson(e))
          .toList(),
      tournaments: (data['tournaments'] as List<dynamic>)
          .map((e) => TournamentModel.fromJson(e))
          .toList(),
      accountStats: data['accountStats'] != null
          ? AccountStatsModel.fromJson(
              (data['accountStats'] as Map<String, dynamic>),
            )
          : null,
      matchwiseStats: data['matchWiseStats'] != null
          ? (data['matchWiseStats'] as List<dynamic>)
                .map((e) => MatchWiseStatsModel.fromJson(e))
                .toList()
          : [],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      profileId: profileId,
      name: name,
      email: email,
      phoneNumber: phoneNumber ?? "1234567890",
      countryCode: countryCode ?? "+91",
      location: location,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      unreadNotifications: unreadNotifications,
      profilePic: profilePic,
      followers: followers,
      following: following,
      userFollow: userFollow,
      userMatches: userMatches.map((e) => e.toEntity()).toList(),
      tournaments: tournaments.map((e) => e.toEntity()).toList(),
      accountStats: accountStats?.toEntity(),
      matchwiseStats: matchwiseStats.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "profileId": profileId,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber ?? "1234567890",
      "countryCode": countryCode ?? "+91",
      "location": location,
      "playerType": playerType,
      "batterType": batterType,
      "bowlerType": bowlerType,
      "unreadNotifications": unreadNotifications,
      "profilePic": profilePic,
      "userFollow": userFollow,
    };
  }

  UserModel copyWith({
    String? profileId,
    String? name,
    String? profilePic,
    int? unreadNotifications,
    String? email,
    String? phoneNumber,
    String? countryCode,
    LocationEntity? location,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
    int? followers,
    bool? userFollow,
    int? following,
    List<MatchModel>? userMatches,
    List<TournamentModel>? tournaments,
    List<MatchWiseStatsModel>? matchwiseStats,
  }) {
    return UserModel(
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      location: location ?? this.location,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
      userFollow: userFollow ?? this.userFollow,
      userMatches: userMatches ?? this.userMatches,
      tournaments: tournaments ?? this.tournaments,
      matchwiseStats: matchwiseStats ?? this.matchwiseStats,
    );
  }
}
