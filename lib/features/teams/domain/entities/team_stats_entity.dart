// ignore_for_file: public_member_api_docs, sort_constructors_first
class TeamStatsEntity {
  final int matches;
  final int wins;
  final int losses;
  final int draws;
  final int tossWon;
  final int abandoned;
  final int batFirst;
  final int batFirstWon;

  TeamStatsEntity({
    required this.matches,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.tossWon,
    required this.abandoned,
    required this.batFirst,
    required this.batFirstWon,
  });
}
