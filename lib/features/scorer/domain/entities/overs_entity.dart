// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';

class OversEntity {
  final int overNumber;
  int runs;
  int wickets;
  final MatchTeamEntity teamEntity;
  final MatchPlayerEntity bowler;
  final List<BallEntity> balls;

  OversEntity({
    required this.runs,
    required this.wickets,
    required this.overNumber,
    required this.teamEntity,
    required this.bowler,
    required this.balls,
  });

  int get legalDeliveries => balls
      .where(
        (e) =>
            !e.isExtra ||
            (e.extraType != null && e.extraType == ExtraType.moreRuns),
      )
      .length;

  int get overRuns => balls.fold(0, (sum, ball) => sum + ball.totalRuns);

  int get overWickets => balls.where((e) => e.wicketType != null).length;
}
