import 'package:cricklo/features/account/domain/entities/matchwise_stats_entity.dart';

class MatchWiseStatsModel {
  final String matchId;
  final DateTime date;
  final DateTime time;
  final String format;
  final String status;

  final String tournamentId;
  final String tournamentName;

  final String teamId;
  final String teamName;

  final String oppositionTeamId;
  final String oppositionTeamName;
  final String? oppositionLogo;

  final int? runs;
  final int? balls;
  final int? fours;
  final int? sixes;
  final double? strikeRate;
  final String? dismissalType;
  final int? battingPosition;

  final double? overs;
  final int? bowlingRuns;
  final int? wickets;
  final int? maidens;
  final double? economy;
  final int? dots;

  final int? catches;
  final int? stumpings;
  final int? runouts;

  const MatchWiseStatsModel({
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

  factory MatchWiseStatsModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return MatchWiseStatsModel(
      matchId: json['matchId'] ?? '',
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      format: json['format'] ?? '',
      status: json['status'] ?? '',
      tournamentId: json['tournament']?['tournamentId'] ?? '',
      tournamentName: json['tournament']?['name'] ?? '',
      teamId: json['team']?['teamId'] ?? '',
      teamName: json['team']?['name'] ?? '',
      oppositionTeamId: json['opposition']?['teamId'] ?? '',
      oppositionTeamName: json['opposition']?['name'] ?? '',
      oppositionLogo: json['opposition']?['logo'],
      runs: json['batting']?['runs'],
      balls: json['batting']?['balls'],
      fours: json['batting']?['fours'],
      sixes: json['batting']?['sixes'],
      strikeRate: (json['batting']?['strikeRate'] as num?)?.toDouble(),
      dismissalType: json['batting']?['dismissalType'],
      battingPosition: json['batting']?['battingPosition'],
      overs: (json['bowling']?['overs'] as num?)?.toDouble(),
      bowlingRuns: json['bowling']?['runs'],
      wickets: json['bowling']?['wickets'],
      maidens: json['bowling']?['maidens'],
      economy: (json['bowling']?['economy'] as num?)?.toDouble(),
      dots: json['bowling']?['dots'],
      catches: json['fielding']?['catches'],
      stumpings: json['fielding']?['stumpings'],
      runouts: json['fielding']?['runouts'],
    );
  }

  factory MatchWiseStatsModel.fromEntity(MatchWiseStatsEntity entity) {
    return MatchWiseStatsModel(
      matchId: entity.matchId,
      date: entity.date,
      time: entity.time,
      format: entity.format,
      status: entity.status,
      tournamentId: entity.tournamentId,
      tournamentName: entity.tournamentName,
      teamId: entity.teamId,
      teamName: entity.teamName,
      oppositionTeamId: entity.oppositionTeamId,
      oppositionTeamName: entity.oppositionTeamName,
      oppositionLogo: entity.oppositionLogo,
      runs: entity.runs,
      balls: entity.balls,
      fours: entity.fours,
      sixes: entity.sixes,
      strikeRate: entity.strikeRate,
      dismissalType: entity.dismissalType,
      battingPosition: entity.battingPosition,
      overs: entity.overs,
      bowlingRuns: entity.bowlingRuns,
      wickets: entity.wickets,
      maidens: entity.maidens,
      economy: entity.economy,
      dots: entity.dots,
      catches: entity.catches,
      stumpings: entity.stumpings,
      runouts: entity.runouts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'format': format,
      'status': status,
      'tournamentId': tournamentId,
      'tournamentName': tournamentName,
      'teamId': teamId,
      'teamName': teamName,
      'oppositionTeamId': oppositionTeamId,
      'oppositionTeamName': oppositionTeamName,
      'oppositionLogo': oppositionLogo,
      'batting': {
        'runs': runs,
        'balls': balls,
        'fours': fours,
        'sixes': sixes,
        'strikeRate': strikeRate,
        'dismissalType': dismissalType,
        'battingPosition': battingPosition,
      },
      'bowling': {
        'overs': overs,
        'runs': bowlingRuns,
        'wickets': wickets,
        'maidens': maidens,
        'economy': economy,
        'dots': dots,
      },
      'fielding': {
        'catches': catches,
        'stumpings': stumpings,
        'runouts': runouts,
      },
    };
  }

  MatchWiseStatsEntity toEntity() {
    return MatchWiseStatsEntity(
      matchId: matchId,
      date: date,
      time: time,
      format: format,
      status: status,
      tournamentId: tournamentId,
      tournamentName: tournamentName,
      teamId: teamId,
      teamName: teamName,
      oppositionTeamId: oppositionTeamId,
      oppositionTeamName: oppositionTeamName,
      oppositionLogo: oppositionLogo,
      runs: runs,
      balls: balls,
      fours: fours,
      sixes: sixes,
      strikeRate: strikeRate,
      dismissalType: dismissalType,
      battingPosition: battingPosition,
      overs: overs,
      bowlingRuns: bowlingRuns,
      wickets: wickets,
      maidens: maidens,
      economy: economy,
      dots: dots,
      catches: catches,
      stumpings: stumpings,
      runouts: runouts,
    );
  }
}
