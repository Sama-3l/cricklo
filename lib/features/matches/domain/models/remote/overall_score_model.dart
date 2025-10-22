import 'package:cricklo/features/matches/domain/entities/overall_score_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';

class OverallScoreModel {
  final TeamModel team;
  final int score;
  final String overs;
  final int wickets;

  OverallScoreModel({
    required this.team,
    required this.score,
    required this.overs,
    required this.wickets,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'team': team.toJson(),
      'score': score,
      'overs': overs,
      'wickets': wickets,
    };
  }

  OverallScoreEntity toEntity() {
    return OverallScoreEntity(
      team: team.toEntity(),
      score: score,
      overs: overs,
      wickets: wickets,
    );
  }

  factory OverallScoreModel.fromJson(
    Map<String, dynamic> map,
    TeamModel teamA,
    TeamModel teamB,
  ) {
    final teamId = map['teamId'] as String;
    final team = teamId == teamA.id ? teamA : teamB;
    return OverallScoreModel(
      team: team,
      score: map['score'] as int,
      overs: map['overs'] as String,
      wickets: map['wickets'] as int,
    );
  }

  factory OverallScoreModel.fromEntity(OverallScoreEntity entity) {
    return OverallScoreModel(
      team: TeamModel.fromEntity(entity.team),
      score: entity.score,
      overs: entity.overs,
      wickets: entity.wickets,
    );
  }
}
