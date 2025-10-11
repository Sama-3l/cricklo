class MatchPlayerStatsEntity {
  int runs;
  int balls;
  int n4s;
  int n6s;
  double sr;
  String overs;
  int runsGiven;
  int maidens;
  int wickets;
  double eco;
  bool out;

  MatchPlayerStatsEntity({
    required this.runs,
    required this.balls,
    required this.n4s,
    required this.n6s,
    required this.sr,
    required this.overs,
    required this.runsGiven,
    required this.maidens,
    required this.wickets,
    required this.eco,
    required this.out,
  });
}
