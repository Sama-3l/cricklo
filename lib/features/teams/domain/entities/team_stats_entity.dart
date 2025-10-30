class TeamStatsEntity {
  final int matches;
  final int wins;
  final int losses;
  final int draws;
  final int abandoned;
  final double nrr;
  final int tossWins;
  final int batFirst;
  final int batFirstWins;
  final int batFirstLoss;
  final int bowlFirst;
  final int bowlFirstWins;
  final int bowlFirstLoss;

  final int highestRunsScored;

  final int lowestRunsScored;

  final int highestRunsConceded;

  final int lowestRunsConceded;

  TeamStatsEntity({
    required this.matches,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.abandoned,
    required this.nrr,
    required this.tossWins,
    required this.batFirst,
    required this.batFirstWins,
    required this.batFirstLoss,
    required this.bowlFirst,
    required this.bowlFirstWins,
    required this.bowlFirstLoss,
    required this.highestRunsScored,
    required this.lowestRunsScored,
    required this.highestRunsConceded,
    required this.lowestRunsConceded,
  });
}
