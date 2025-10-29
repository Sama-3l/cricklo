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

  final String? highestRunsScoredMatchId;
  final DateTime? highestRunsScoredDate;

  final String? lowestRunsScoredMatchId;
  final DateTime? lowestRunsScoredDate;

  final String? highestRunsConcededMatchId;
  final DateTime? highestRunsConcededDate;

  final String? lowestRunsConcededMatchId;
  final DateTime? lowestRunsConcededDate;

  const TeamStatsEntity({
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
    this.highestRunsScoredMatchId,
    this.highestRunsScoredDate,
    this.lowestRunsScoredMatchId,
    this.lowestRunsScoredDate,
    this.highestRunsConcededMatchId,
    this.highestRunsConcededDate,
    this.lowestRunsConcededMatchId,
    this.lowestRunsConcededDate,
  });
}
