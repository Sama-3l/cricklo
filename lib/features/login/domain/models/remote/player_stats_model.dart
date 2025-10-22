// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class PlayerStatsModel {
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

  const PlayerStatsModel({
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

  Map<String, dynamic> fromJson() {
    return <String, dynamic>{
      'matchType': matchType.matchType,
      'matches': matches,
      'innings': innings,
      'runs': runs,
      'balls': balls,
      'highest': highest,
      'average': average,
      'sr': sr,
      'notOuts': notOuts,
      'ducks': ducks,
      'hundreds': hundreds,
      'fifties': fifties,
      'thirties': thirties,
      'sixes': sixes,
      'fours': fours,
      'dots': dots,
      'bowlingMatches': bowlingMatches,
      'bowlingInnings': bowlingInnings,
      'overs': overs,
      'wickets': wickets,
      'bowlingRuns': bowlingRuns,
      'maidens': maidens,
      'bowlingAverage': bowlingAverage,
      'economy': economy,
      'threeW': threeW,
      'fiveW': fiveW,
      'catches': catches,
      'stumpings': stumpings,
      'runouts': runouts,
    };
  }

  factory PlayerStatsModel.fromJson(Map<String, dynamic> map) {
    return PlayerStatsModel(
      matchType: MatchType.values
          .where((e) => map['format'] == e.matchType)
          .first,
      matches: map['matches'] as int,
      innings: map['innings'] as int,
      runs: map['runs'] as int,
      balls: map['balls'] as int,
      highest: map['highest'] as int,
      average: map['average'] as double,
      sr: map['sr'] as double,
      notOuts: map['notOuts'] as int,
      ducks: map['ducks'] as int,
      hundreds: map['hundreds'] as int,
      fifties: map['fifties'] as int,
      thirties: map['thirties'] as int,
      sixes: map['sixes'] as int,
      fours: map['fours'] as int,
      dots: map['dots'] as int,
      bowlingMatches: map['bowlingMatches'] as int,
      bowlingInnings: map['bowlingInnings'] as int,
      overs: map['overs'] as int,
      wickets: map['wickets'] as int,
      bowlingRuns: map['bowlingRuns'] as int,
      maidens: map['maidens'] as int,
      bowlingAverage: map['bowlingAverage'] as double,
      economy: map['economy'] as double,
      threeW: map['threeW'] as int,
      fiveW: map['fiveW'] as int,
      catches: map['catches'] as int,
      stumpings: map['stumpings'] as int,
      runouts: map['runouts'] as int,
    );
  }
}
