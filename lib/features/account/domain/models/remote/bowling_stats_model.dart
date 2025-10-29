import 'package:cricklo/features/account/domain/entities/bowling_stats_entity.dart';

class BowlingStatsModel {
  final String format;
  final int matches;
  final int innings;
  final double overs; // use double for fractional overs if needed
  final int wickets;
  final int runs;
  final int maidens;
  final double average;
  final double economy;
  final double strikeRate;
  final int threeWickets;
  final int fiveWickets;
  final int dots;

  BowlingStatsModel({
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

  factory BowlingStatsModel.fromJson(Map<String, dynamic> json) {
    // Overs may be int or double in API — handle safely
    double parseOvers(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return BowlingStatsModel(
      format: json['format']?.toString() ?? '',
      matches: (json['matches'] as num?)?.toInt() ?? 0,
      innings: (json['innings'] as num?)?.toInt() ?? 0,
      overs: parseOvers(json['overs']),
      wickets: (json['wickets'] as num?)?.toInt() ?? 0,
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      maidens: (json['maidens'] as num?)?.toInt() ?? 0,
      average: parseDouble(json['average']),
      economy: parseDouble(json['economy']),
      strikeRate: parseDouble(json['strikeRate']),
      threeWickets: (json['threeWickets'] as num?)?.toInt() ?? 0,
      fiveWickets: (json['fiveWickets'] as num?)?.toInt() ?? 0,
      dots: (json['dots'] as num?)?.toInt() ?? 0,
    );
  }

  BowlingStatsEntity toEntity() {
    return BowlingStatsEntity(
      format: format,
      matches: matches,
      innings: innings,
      overs: overs,
      wickets: wickets,
      runs: runs,
      maidens: maidens,
      average: average,
      economy: economy,
      strikeRate: strikeRate,
      threeWickets: threeWickets,
      fiveWickets: fiveWickets,
      dots: dots,
    );
  }
}
