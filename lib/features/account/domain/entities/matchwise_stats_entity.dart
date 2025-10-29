class MatchWiseStatsEntity {
  final String matchId;
  final DateTime date;
  final DateTime time;
  final String format;
  final String status;

  // Tournament info
  final String tournamentId;
  final String tournamentName;

  // Team info
  final String teamId;
  final String teamName;

  // Opposition info
  final String oppositionTeamId;
  final String oppositionTeamName;
  final String? oppositionLogo;

  // Batting
  final int? runs;
  final int? balls;
  final int? fours;
  final int? sixes;
  final double? strikeRate;
  final String? dismissalType;
  final int? battingPosition;

  // Bowling
  final double? overs;
  final int? bowlingRuns;
  final int? wickets;
  final int? maidens;
  final double? economy;
  final int? dots;

  // Fielding
  final int? catches;
  final int? stumpings;
  final int? runouts;

  const MatchWiseStatsEntity({
    required this.matchId,
    required this.date,
    required this.time,
    required this.format,
    required this.status,
    required this.tournamentId,
    required this.tournamentName,
    required this.teamId,
    required this.teamName,
    required this.oppositionTeamId,
    required this.oppositionTeamName,
    this.oppositionLogo,
    this.runs,
    this.balls,
    this.fours,
    this.sixes,
    this.strikeRate,
    this.dismissalType,
    this.battingPosition,
    this.overs,
    this.bowlingRuns,
    this.wickets,
    this.maidens,
    this.economy,
    this.dots,
    this.catches,
    this.stumpings,
    this.runouts,
  });
}
