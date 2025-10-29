import 'package:cricklo/features/account/domain/entities/player_stats_entity.dart';
import 'package:cricklo/features/account/domain/models/remote/batting_stat_model.dart';
import 'package:cricklo/features/account/domain/models/remote/bowling_stats_model.dart';
import 'package:cricklo/features/account/domain/models/remote/fielding_stats_model.dart';

class AccountStatsModel {
  final List<BattingStatsModel> batting;
  final List<BowlingStatsModel> bowling;
  final List<FieldingStatsModel> fielding;

  AccountStatsModel({
    required this.batting,
    required this.bowling,
    required this.fielding,
  });

  factory AccountStatsModel.fromJson(Map<String, dynamic> json) {
    return AccountStatsModel(
      batting:
          (json['batting'] as List<dynamic>?)
              ?.map((e) => BattingStatsModel.fromJson(e))
              .toList() ??
          [],
      bowling:
          (json['bowling'] as List<dynamic>?)
              ?.map((e) => BowlingStatsModel.fromJson(e))
              .toList() ??
          [],
      fielding:
          (json['fielding'] as List<dynamic>?)
              ?.map((e) => FieldingStatsModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  AccountStatsEntity toEntity() {
    return AccountStatsEntity(
      batting: batting.map((e) => e.toEntity()).toList(),
      bowling: bowling.map((e) => e.toEntity()).toList(),
      fielding: fielding.map((e) => e.toEntity()).toList(),
    );
  }
}
