class BattingStatsEntity {
  final String format;
  final int matches;
  final int innings;
  final int runs;
  final int balls;
  final int highest;
  final double average;
  final double strikeRate;
  final int notOuts;
  final int ducks;
  final int hundreds;
  final int fifties;
  final int thirties;
  final int sixes;
  final int fours;
  final int dots;

  BattingStatsEntity({
    required this.format,
    required this.matches,
    required this.innings,
    required this.runs,
    required this.balls,
    required this.highest,
    required this.average,
    required this.strikeRate,
    required this.notOuts,
    required this.ducks,
    required this.hundreds,
    required this.fifties,
    required this.thirties,
    required this.sixes,
    required this.fours,
    required this.dots,
  });
}
