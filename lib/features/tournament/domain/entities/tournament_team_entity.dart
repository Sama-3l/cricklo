// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class TournamentTeamEntity {
  final TeamEntity teamEntity;
  final int matches;
  final int won;
  final int loss;
  final int points;
  final double nrr;
  TournamentTeamEntity({
    required this.teamEntity,
    required this.matches,
    required this.won,
    required this.loss,
    required this.points,
    required this.nrr,
  });

  TournamentTeamEntity copyWith({
    TeamEntity? teamEntity,
    int? matches,
    int? won,
    int? loss,
    int? points,
    double? nrr,
  }) {
    return TournamentTeamEntity(
      teamEntity: teamEntity ?? this.teamEntity,
      matches: matches ?? this.matches,
      won: won ?? this.won,
      loss: loss ?? this.loss,
      points: points ?? this.points,
      nrr: nrr ?? this.nrr,
    );
  }
}
