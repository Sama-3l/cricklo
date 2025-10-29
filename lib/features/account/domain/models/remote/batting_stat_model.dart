import 'package:cricklo/features/account/domain/entities/batting_stats_entity.dart';

class BattingStatsModel {
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

  BattingStatsModel({
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

  factory BattingStatsModel.fromJson(Map<String, dynamic> json) {
    return BattingStatsModel(
      format: json['format']?.toString() ?? '',
      matches: (json['matches'] as num?)?.toInt() ?? 0,
      innings: (json['innings'] as num?)?.toInt() ?? 0,
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      balls: (json['balls'] as num?)?.toInt() ?? 0,
      highest: (json['highest'] as num?)?.toInt() ?? 0,
      average: (json['average'] is num)
          ? (json['average'] as num).toDouble()
          : double.tryParse((json['average'] ?? '').toString()) ?? 0.0,
      strikeRate: (json['strikeRate'] is num)
          ? (json['strikeRate'] as num).toDouble()
          : double.tryParse((json['strikeRate'] ?? '').toString()) ?? 0.0,
      notOuts: (json['notOuts'] as num?)?.toInt() ?? 0,
      ducks: (json['ducks'] as num?)?.toInt() ?? 0,
      hundreds: (json['hundreds'] as num?)?.toInt() ?? 0,
      fifties: (json['fifties'] as num?)?.toInt() ?? 0,
      thirties: (json['thirties'] as num?)?.toInt() ?? 0,
      sixes: (json['sixes'] as num?)?.toInt() ?? 0,
      fours: (json['fours'] as num?)?.toInt() ?? 0,
      dots: (json['dots'] as num?)?.toInt() ?? 0,
    );
  }

  BattingStatsEntity toEntity() {
    return BattingStatsEntity(
      format: format,
      matches: matches,
      innings: innings,
      runs: runs,
      balls: balls,
      highest: highest,
      average: average,
      strikeRate: strikeRate,
      notOuts: notOuts,
      ducks: ducks,
      hundreds: hundreds,
      fifties: fifties,
      thirties: thirties,
      sixes: sixes,
      fours: fours,
      dots: dots,
    );
  }
}
