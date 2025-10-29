class BowlingStatsEntity {
  final String format;
  final int matches;
  final int innings;
  final double overs;
  final int wickets;
  final int runs;
  final int maidens;
  final double average;
  final double economy;
  final double strikeRate;
  final int threeWickets;
  final int fiveWickets;
  final int dots;

  BowlingStatsEntity({
    required this.format,
    required this.matches,
    required this.innings,
    required this.overs,
    required this.wickets,
    required this.runs,
    required this.maidens,
    required this.average,
    required this.economy,
    required this.strikeRate,
    required this.threeWickets,
    required this.fiveWickets,
    required this.dots,
  });
}
