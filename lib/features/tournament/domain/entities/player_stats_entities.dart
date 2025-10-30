class TournamentBattingStatsEntity {
  final String playerName;
  final int runs;
  final String teamName;
  final String teamLogo;
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

  TournamentBattingStatsEntity({
    required this.playerName,
    required this.runs,
    required this.teamName,
    required this.teamLogo,
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

class TournamentBowlingStatsEntity {
  final String playerName;
  final int wickets;
  final int runs;
  final String teamName;
  final String teamLogo;
  final double overs;
  final int maidens;
  final double average;
  final double economy;
  final double strikeRate;
  final int threeWickets;
  final int fiveWickets;
  final int matches;

  TournamentBowlingStatsEntity({
    required this.playerName,
    required this.wickets,
    required this.runs,
    required this.teamName,
    required this.teamLogo,
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

class TournamentFieldingStatsEntity {
  final String playerName;
  final int catches;
  final String teamName;
  final String teamLogo;
  final int stumpings;
  final int runouts;
  final int matches;

  TournamentFieldingStatsEntity({
    required this.playerName,
    required this.catches,
    required this.teamName,
    required this.teamLogo,
    required this.stumpings,
    required this.runouts,
    required this.matches,
  });
}
