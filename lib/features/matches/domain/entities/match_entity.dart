// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/matches/domain/entities/overall_score_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class MatchEntity {
  final String matchID;
  final String tournamentName;
  DateTime dateAndTime;
  final int overs;
  final MatchType matchType;
  final MatchCategory matchCategory;
  final TeamEntity teamA;
  bool abandoned;
  final MatchStatus matchStatus;
  final TeamEntity teamB;
  LocationEntity? location;
  Map<String, dynamic> scorer;
  String? tossWinner; // TeamID
  TossChoice? tossChoice;
  String? winner;
  bool draw;
  final OverallScoreEntity? teamAScore;
  final OverallScoreEntity? teamBScore;
  final DateTime? endDateTime;

  MatchEntity({
    required this.matchID,
    required this.tournamentName,
    required this.dateAndTime,
    required this.overs,
    required this.matchCategory,
    this.abandoned = false,
    required this.matchStatus,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer,
    this.draw = false,
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
    String? tournamentName,
    MatchCategory? matchCategory,
    MatchStatus? matchStatus,
    DateTime? dateAndTime,
    DateTime? endDateTime,
    int? overs,
    MatchType? matchType,
    TeamEntity? teamA,
    TeamEntity? teamB,
    bool? abandoned,
    bool? draw,
    LocationEntity? location,
    Map<String, dynamic>? scorer,
  }) {
    return MatchEntity(
      matchID: matchID ?? this.matchID,
      tournamentName: tournamentName ?? this.tournamentName,
      matchCategory: matchCategory ?? this.matchCategory,
      matchStatus: matchStatus ?? this.matchStatus,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      endDateTime: endDateTime ?? this.endDateTime,
      overs: overs ?? this.overs,
      draw: draw ?? this.draw,
      matchType: matchType ?? this.matchType,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      location: location ?? this.location,
      scorer: scorer ?? this.scorer,
      abandoned: abandoned ?? this.abandoned,
    );
  }
}
