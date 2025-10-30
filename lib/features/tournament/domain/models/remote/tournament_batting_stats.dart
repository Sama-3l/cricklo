import 'package:cricklo/features/tournament/domain/entities/player_stats_entities.dart';

class TournamentBattingStatsModel {
  final String playerName;
  final int runs;
  final int balls;
  final int fours;
  final int sixes;
  final int hundreds;
  final int fifties;
  final int thirties;
  final int ducks;
  final double average;
  final double strikeRate;
  final int matches;

  TournamentBattingStatsModel({
    required this.playerName,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    required this.hundreds,
    required this.fifties,
    required this.thirties,
    required this.ducks,
    required this.average,
    required this.strikeRate,
    required this.matches,
  });

  factory TournamentBattingStatsModel.fromJson(Map<String, dynamic> json) {
    return TournamentBattingStatsModel(
      playerName: json['player']['name'],
      runs: json['runs'] ?? 0,
      balls: json['balls'] ?? 0,
      fours: json['fours'] ?? 0,
      sixes: json['sixes'] ?? 0,
      hundreds: json['hundreds'] ?? 0,
      fifties: json['fifties'] ?? 0,
      thirties: json['thirties'] ?? 0,
      ducks: json['ducks'] ?? 0,
      average: (json['average'] ?? 0).toDouble(),
      strikeRate: (json['strikeRate'] ?? 0).toDouble(),
      matches: json['matches'] ?? 0,
    );
  }

  TournamentBattingStatsEntity toEntity() => TournamentBattingStatsEntity(
    playerName: playerName,
    runs: runs,
    balls: balls,
    fours: fours,
    sixes: sixes,
    hundreds: hundreds,
    fifties: fifties,
    thirties: thirties,
    ducks: ducks,
    average: average,
    strikeRate: strikeRate,
    matches: matches,
  );

  factory TournamentBattingStatsModel.fromEntity(
    TournamentBattingStatsEntity entity,
  ) => TournamentBattingStatsModel(
    playerName: entity.playerName,
    runs: entity.runs,
    balls: entity.balls,
    fours: entity.fours,
    sixes: entity.sixes,
    hundreds: entity.hundreds,
    fifties: entity.fifties,
    thirties: entity.thirties,
    ducks: entity.ducks,
    average: entity.average,
    strikeRate: entity.strikeRate,
    matches: entity.matches,
  );
}

class TournamentBowlingStatsModel {
  final String playerName;
  final int wickets;
  final int runs;
  final double overs;
  final int maidens;
  final double average;
  final double economy;
  final double strikeRate;
  final int threeWickets;
  final int fiveWickets;
  final int matches;

  TournamentBowlingStatsModel({
    required this.playerName,
    required this.wickets,
    required this.runs,
    required this.overs,
    required this.maidens,
    required this.average,
    required this.economy,
    required this.strikeRate,
    required this.threeWickets,
    required this.fiveWickets,
    required this.matches,
  });

  factory TournamentBowlingStatsModel.fromJson(Map<String, dynamic> json) {
    return TournamentBowlingStatsModel(
      playerName: json["player"]["name"],
      wickets: json['wickets'] ?? 0,
      runs: json['runs'] ?? 0,
      overs: (json['overs'] ?? 0).toDouble(),
      maidens: json['maidens'] ?? 0,
      average: (json['average'] ?? 0).toDouble(),
      economy: (json['economy'] ?? 0).toDouble(),
      strikeRate: (json['strikeRate'] ?? 0).toDouble(),
      threeWickets: json['threeWickets'] ?? 0,
      fiveWickets: json['fiveWickets'] ?? 0,
      matches: json['matches'] ?? 0,
    );
  }

  TournamentBowlingStatsEntity toEntity() => TournamentBowlingStatsEntity(
    playerName: playerName,
    wickets: wickets,
    runs: runs,
    overs: overs,
    maidens: maidens,
    average: average,
    economy: economy,
    strikeRate: strikeRate,
    threeWickets: threeWickets,
    fiveWickets: fiveWickets,
    matches: matches,
  );

  factory TournamentBowlingStatsModel.fromEntity(
    TournamentBowlingStatsEntity entity,
  ) => TournamentBowlingStatsModel(
    playerName: entity.playerName,
    wickets: entity.wickets,
    runs: entity.runs,
    overs: entity.overs,
    maidens: entity.maidens,
    average: entity.average,
    economy: entity.economy,
    strikeRate: entity.strikeRate,
    threeWickets: entity.threeWickets,
    fiveWickets: entity.fiveWickets,
    matches: entity.matches,
  );
}

class TournamentFieldingStatsModel {
  final String player;
  final int catches;
  final int stumpings;
  final int runouts;
  final int matches;

  TournamentFieldingStatsModel({
    required this.player,
    required this.catches,
    required this.stumpings,
    required this.runouts,
    required this.matches,
  });

  factory TournamentFieldingStatsModel.fromJson(Map<String, dynamic> json) {
    return TournamentFieldingStatsModel(
      player: json['player']['name'],
      catches: json['catches'] ?? 0,
      stumpings: json['stumpings'] ?? 0,
      runouts: json['runouts'] ?? 0,
      matches: json['matches'] ?? 0,
    );
  }

  TournamentFieldingStatsEntity toEntity() => TournamentFieldingStatsEntity(
    playerName: player,
    catches: catches,
    stumpings: stumpings,
    runouts: runouts,
    matches: matches,
  );

  factory TournamentFieldingStatsModel.fromEntity(
    TournamentFieldingStatsEntity entity,
  ) => TournamentFieldingStatsModel(
    player: entity.playerName,
    catches: entity.catches,
    stumpings: entity.stumpings,
    runouts: entity.runouts,
    matches: entity.matches,
  );
}
