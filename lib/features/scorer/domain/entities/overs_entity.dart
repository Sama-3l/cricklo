// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';

class OversEntity {
  final int overNumber;
  int runs;
  int wickets;
  int player1runs;
  int player1balls;
  String player1Id;
  String player1Name;
  int player2runs;
  int player2balls;
  String player2Id;
  String player2Name;
  String bowlerId;
  String bowlerName;
  String bowlerOvers;
  int bowlerRuns;
  int bowlerMaidens;
  int bowlerWickets;
  final MatchPlayerEntity bowler;
  final List<BallEntity> balls;

  OversEntity({
    required this.overNumber,
    required this.runs,
    required this.wickets,
    required this.player1runs,
    required this.player1balls,
    required this.player1Id,
    required this.player1Name,
    required this.player2runs,
    required this.player2balls,
    required this.player2Id,
    required this.player2Name,
    required this.bowlerId,
    required this.bowlerName,
    required this.bowlerOvers,
    required this.bowlerRuns,
    required this.bowlerMaidens,
    required this.bowlerWickets,
    required this.bowler,
    required this.balls,
  });

  int get legalDeliveries => balls.where((e) {
    if (!e.isExtra) return true;

    if (e.extraType == ExtraType.bye || e.extraType == ExtraType.legBye) {
      return true;
    }

    return false;
  }).length;

  int get overRuns => balls.fold(0, (sum, ball) => sum + ball.totalRuns);

  int get overWickets => balls.where((e) => e.wicketType != null).length;
}
