// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';

class BallEntity {
  final int runs;
  final bool isExtra;
  final ExtraType? extraType;
  final WicketType? wicketType;
  String? secondBatsmanId;
  String? batsmanId;
  String? bowlerId;
  String? fielderId;
  MatchPlayerEntity? secondBatsman;
  MatchPlayerEntity? batsman;
  MatchPlayerEntity? bowler;
  MatchPlayerEntity? fielder;
  final int? sector;

  BallEntity({
    required this.runs,
    required this.isExtra,
    this.secondBatsman,
    this.extraType,
    this.wicketType,
    this.sector,
    this.batsman,
    this.bowler,
    this.fielder,
    this.secondBatsmanId,
    this.batsmanId,
    this.bowlerId,
    this.fielderId,
  });

  int get totalRuns =>
      runs +
      (!isExtra
          ? 0
          : extraType != null &&
                (extraType == ExtraType.noBall || extraType == ExtraType.wide)
          ? 1
          : 0);

  int get extraRuns {
    if (!isExtra || extraType == null) return 0;

    switch (extraType!) {
      case ExtraType.noBall:
        // 1 penalty run, plus any non-bat runs (e.g. overthrow)
        return 1 + (runs > 0 ? 0 : 0);
      case ExtraType.wide:
        // 1 penalty run, plus any extra run(s) scored during wide
        return 1 + runs;
      case ExtraType.bye:
      case ExtraType.legBye:
        // all runs count as extras
        return runs;
      case ExtraType.penalty:
      case ExtraType.bonus:
      case ExtraType.moreRuns:
        return runs;
    }
  }
}
