// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';

class TournamentTeamModel {
  final TeamModel teamModel;
  final int matches;
  final int won;
  final int loss;
  final int points;
  final double nrr;
  TournamentTeamModel({
    required this.teamModel,
    required this.matches,
    required this.won,
    required this.loss,
    required this.points,
    required this.nrr,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'teamModel': teamModel.toJson(),
      'matches': matches,
      'won': won,
      'loss': loss,
      'points': points,
      'nrr': nrr,
    };
  }

  TournamentTeamEntity toEntity() {
    return TournamentTeamEntity(
      teamEntity: teamModel.toEntity(),
      matches: matches,
      won: won,
      loss: loss,
      points: points,
      nrr: nrr,
    );
  }

  factory TournamentTeamModel.fromJson(Map<String, dynamic> map) {
    return TournamentTeamModel(
      teamModel: TeamModel.fromJson(map['teamModel'] as Map<String, dynamic>),
      matches: map['matches'] as int,
      won: map['won'] as int,
      loss: map['loss'] as int,
      points: map['points'] as int,
      nrr: map['nrr'] as double,
    );
  }

  factory TournamentTeamModel.fromEntity(TournamentTeamEntity entity) {
    return TournamentTeamModel(
      teamModel: TeamModel.fromEntity(entity.teamEntity),
      matches: entity.matches,
      won: entity.won,
      loss: entity.loss,
      points: entity.points,
      nrr: entity.nrr,
    );
  }
}
