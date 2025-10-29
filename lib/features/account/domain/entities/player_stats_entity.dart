import 'package:cricklo/features/account/domain/entities/batting_stats_entity.dart';
import 'package:cricklo/features/account/domain/entities/bowling_stats_entity.dart';
import 'package:cricklo/features/account/domain/entities/fielding_stats_entity.dart';

class AccountStatsEntity {
  final List<BattingStatsEntity> batting;
  final List<BowlingStatsEntity> bowling;
  final List<FieldingStatsEntity> fielding;

  AccountStatsEntity({
    required this.batting,
    required this.bowling,
    required this.fielding,
  });
}
