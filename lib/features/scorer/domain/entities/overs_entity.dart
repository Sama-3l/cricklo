// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';

class OversEntity {
  final int overNumber;
  final MatchTeamEntity teamEntity;
  final MatchPlayerEntity bowler;
  final List<BallEntity> balls;

  OversEntity({
    required this.overNumber,
    required this.teamEntity,
    required this.bowler,
    required this.balls,
  });

  int get legalDeliveries => balls.map((e) => !e.isExtra).length;

  int get overRuns => balls.fold(0, (sum, ball) => sum + ball.totalRuns);
}
