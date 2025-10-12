// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/innings_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_entity.dart';

class MatchCenterEntity {
  final String matchID;
  final DateTime dateAndTime;
  final int overs;
  final MatchType matchType;
  final MatchTeamEntity teamA;
  final MatchTeamEntity teamB;
  final LocationEntity location;
  final MatchScorerEntity scorer;
  final String? tossWinner; // TeamID
  final TossChoice? tossChoice;
  String? winner;
  final DateTime? endDateTime;
  final List<InningsEntity> innings;
  bool abandoned;

  MatchCenterEntity({
    required this.matchID,
    required this.dateAndTime,
    required this.overs,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer,
    this.tossWinner,
    this.tossChoice,
    this.winner,
    this.endDateTime,
    this.abandoned = false,
    required this.innings,
  });

  MatchTeamEntity? get battingTeam => innings.length <= 1
      ? tossWinner == null
            ? null
            : tossWinner == teamA.id
            ? tossChoice == TossChoice.batting
                  ? teamA
                  : teamB
            : tossChoice == TossChoice.batting
            ? teamB
            : teamA
      : innings.last.battingTeam;

  MatchTeamEntity? get bowlingTeam => innings.length <= 1
      ? tossWinner == null
            ? null
            : tossWinner == teamA.id
            ? tossChoice == TossChoice.batting
                  ? teamB
                  : teamA
            : tossChoice == TossChoice.batting
            ? teamA
            : teamB
      : innings[innings.length - 2].battingTeam;
}
