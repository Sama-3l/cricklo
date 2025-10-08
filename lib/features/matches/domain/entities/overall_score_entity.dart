// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class OverallScoreEntity {
  final TeamEntity team;
  final int score;
  final String overs;
  final int wickets;

  OverallScoreEntity({
    required this.team,
    required this.score,
    required this.overs,
    required this.wickets,
  });
}
