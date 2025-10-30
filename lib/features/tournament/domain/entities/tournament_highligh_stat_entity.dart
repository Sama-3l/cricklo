class TournamentHighlightStat {
  final String title;
  final String playerName;
  final String teamName; // optional, can be empty
  final int value;
  final String logo;

  TournamentHighlightStat({
    required this.title,
    required this.playerName,
    required this.value,
    required this.logo,
    this.teamName = "",
  });
}
