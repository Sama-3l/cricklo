// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/matches/domain/entities/overall_score_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class MatchEntity {
  final String id;
  final String matchID;
  final DateTime dateAndTime;
  final int overs;
  final MatchType matchType;
  final TeamEntity teamA;
  final TeamEntity teamB;
  final LocationEntity location;
  final PlayerEntity scorer1;
  final PlayerEntity scorer2;
  final String? tossWinner; // TeamID
  final TossChoice? tossChoice;
  final String? winner;
  final OverallScoreEntity? teamAScore;
  final OverallScoreEntity? teamBScore;
  final DateTime? endDateTime;

  MatchEntity({
    required this.id,
    required this.matchID,
    required this.dateAndTime,
    required this.overs,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer1,
    required this.scorer2,
    this.tossWinner,
    this.tossChoice,
    this.winner,
    this.teamAScore,
    this.teamBScore,
    this.endDateTime,
  });

  MatchEntity copyWith({
    String? id,
    String? matchID,
    DateTime? dateAndTime,
    DateTime? endDateTime,
    int? overs,
    MatchType? matchType,
    TeamEntity? teamA,
    TeamEntity? teamB,
    LocationEntity? location,
    PlayerEntity? scorer1,
    PlayerEntity? scorer2,
  }) {
    return MatchEntity(
      id: id ?? this.id,
      matchID: matchID ?? this.matchID,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      endDateTime: endDateTime ?? this.endDateTime,
      overs: overs ?? this.overs,
      matchType: matchType ?? this.matchType,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      location: location ?? this.location,
      scorer1: scorer1 ?? this.scorer1,
      scorer2: scorer2 ?? this.scorer2,
    );
  }
}
