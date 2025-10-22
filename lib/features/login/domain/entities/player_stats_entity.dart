import 'package:cricklo/core/utils/constants/enums.dart';

class PlayerStatsEntity {
  final MatchType matchType;
  final int matches;
  final int innings;
  final int runs;
  final int balls;
  final int highest;
  final double average;
  final double sr;
  final int notOuts;
  final int ducks;
  final int hundreds;
  final int fifties;
  final int thirties;
  final int sixes;
  final int fours;
  final int dots;

  final int bowlingMatches;
  final int bowlingInnings;
  final int overs;
  final int wickets;
  final int bowlingRuns;
  final int maidens;
  final double bowlingAverage;
  final double economy;
  final int threeW;
  final int fiveW;

  final int catches;
  final int stumpings;
  final int runouts;

  const PlayerStatsEntity({
    required this.matchType,
    required this.matches,
    required this.innings,
    required this.runs,
    required this.balls,
    required this.highest,
    required this.average,
    required this.sr,
    required this.notOuts,
    required this.ducks,
    required this.hundreds,
    required this.fifties,
    required this.thirties,
    required this.sixes,
    required this.fours,
    required this.dots,
    required this.bowlingMatches,
    required this.bowlingInnings,
    required this.overs,
    required this.wickets,
    required this.bowlingRuns,
    required this.maidens,
    required this.bowlingAverage,
    required this.economy,
    required this.threeW,
    required this.fiveW,
    required this.catches,
    required this.stumpings,
    required this.runouts,
  });
}
