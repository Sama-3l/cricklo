import 'package:cricklo/features/account/domain/entities/fielding_stats_entity.dart';

class FieldingStatsModel {
  final String format;
  final int catches;
  final int stumpings;
  final int runOuts;

  FieldingStatsModel({
    required this.format,
    required this.catches,
    required this.stumpings,
    required this.runOuts,
  });

  factory FieldingStatsModel.fromJson(Map<String, dynamic> json) {
    // Accept multiple key variants: "run-out", "runOut", "runOuts"
    int parseRunOuts(Map<String, dynamic> m) {
      final keys = ['run-out', 'runOut', 'runOuts', 'run_outs'];
      for (final k in keys) {
        if (m.containsKey(k)) {
          final v = m[k];
          if (v is num) return v.toInt();
          return int.tryParse(v?.toString() ?? '') ?? 0;
        }
      }
      return 0;
    }

    return FieldingStatsModel(
      format: json['format']?.toString() ?? '',
      catches: (json['catches'] as num?)?.toInt() ?? 0,
      stumpings: (json['stumping'] as num?)?.toInt() ?? 0,
      runOuts: parseRunOuts(json),
    );
  }

  FieldingStatsEntity toEntity() {
    return FieldingStatsEntity(
      format: format,
      catches: catches,
      stumpings: stumpings,
      runOuts: runOuts,
    );
  }
}
