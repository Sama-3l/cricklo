import 'player_entity.dart';

class TeamBattingStatsEntity {
  final PlayerEntity player;
  final int runs;
  final int balls;
  final int fours;
  final int sixes;
  final int hundreds;
  final int fifties;
  final int thirties;
  final int ducks;
  final double average;
  final double strikeRate;
  final int matches;

  TeamBattingStatsEntity({
    required this.player,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    required this.hundreds,
    required this.fifties,
    required this.thirties,
    required this.ducks,
    required this.average,
    required this.strikeRate,
    required this.matches,
  });
}

class TeamBowlingStatsEntity {
  final PlayerEntity player;
  final int wickets;
  final int runs;
  final double overs;
  final int maidens;
  final double average;
  final double economy;
  final double strikeRate;
  final int threeWickets;
  final int fiveWickets;
  final int matches;

  TeamBowlingStatsEntity({
    required this.player,
    required this.wickets,
    required this.runs,
    required this.overs,
    required this.maidens,
    required this.average,
    required this.economy,
    required this.strikeRate,
    required this.threeWickets,
    required this.fiveWickets,
    required this.matches,
  });
}

class TeamFieldingStatsEntity {
  final PlayerEntity player;
  final int catches;
  final int stumpings;
  final int runouts;
  final int matches;

  TeamFieldingStatsEntity({
    required this.player,
    required this.catches,
    required this.stumpings,
    required this.runouts,
    required this.matches,
  });
}
