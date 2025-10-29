class LeaderboardRowData {
  final String playerName;
  final String? teamName;
  final List<String> stats; // should have 3 values
  final int rank;

  LeaderboardRowData({
    required this.rank,
    required this.playerName,
    this.teamName,
    required this.stats,
  });
}
