import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_player_model.dart';

class BallModel {
  final int runs;
  final bool isExtra;
  final ExtraType? extraType;
  final WicketType? wicketType;
  MatchPlayerModel? secondBatsman;
  MatchPlayerModel? batsman;
  MatchPlayerModel? bowler;
  MatchPlayerModel? fielder;
  final int? sector;

  BallModel({
    required this.runs,
    required this.isExtra,
    this.secondBatsman,
    this.extraType,
    this.wicketType,
    this.sector,
    this.batsman,
    this.bowler,
    this.fielder,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'runs': runs,
      'isExtra': isExtra,
      'extraType': extraType?.name,
      'wicketType': wicketType?.title,
      'secondBatsman': secondBatsman?.playerId,
      'batsman': batsman?.playerId,
      'bowler': bowler?.playerId,
      'fielder': fielder?.playerId,
      'sector': sector,
    };
  }

  BallEntity toEntity() {
    return BallEntity(
      runs: runs,
      isExtra: isExtra,
      extraType: extraType,
      wicketType: wicketType,
      secondBatsman: secondBatsman?.toEntity(),
      batsman: batsman?.toEntity(),
      bowler: bowler?.toEntity(),
      fielder: fielder?.toEntity(),
      sector: sector,
    );
  }

  factory BallModel.fromEntity(BallEntity entity) {
    return BallModel(
      runs: entity.runs,
      isExtra: entity.isExtra,
      extraType: entity.extraType,
      wicketType: entity.wicketType,
      secondBatsman: entity.secondBatsman == null
          ? null
          : MatchPlayerModel.fromEntity(entity.secondBatsman!),
      batsman: entity.batsman == null
          ? null
          : MatchPlayerModel.fromEntity(entity.batsman!),
      bowler: entity.bowler == null
          ? null
          : MatchPlayerModel.fromEntity(entity.bowler!),
      fielder: entity.fielder == null
          ? null
          : MatchPlayerModel.fromEntity(entity.fielder!),
      sector: entity.sector,
    );
  }

  factory BallModel.fromJson(
    Map<String, dynamic> map,
    List<MatchPlayerModel> battingTeam,
    List<MatchPlayerModel> bowlingTeam,
  ) {
    final batsman = battingTeam
        .where((e) => e.playerId == map['batsman'])
        .firstOrNull;
    final secondBatsman = battingTeam
        .where((e) => e.playerId == map['secondBatsman'])
        .firstOrNull;

    final bowler = bowlingTeam
        .where((e) => e.playerId == map['bowler'])
        .firstOrNull;

    final fielder = bowlingTeam
        .where((e) => e.playerId == map['fielder'])
        .firstOrNull;
    return BallModel(
      runs: map['runs'] as int,
      isExtra: map['isExtra'] as bool,
      extraType: map['extraType'] != null
          ? ExtraType.values.where((e) => e.name == map['extraType']).first
          : null,
      wicketType: map['wicketType'] != null
          ? WicketType.values.where((e) => e.name == map['extraType']).first
          : null,
      secondBatsman: secondBatsman,
      batsman: batsman,
      bowler: bowler,
      fielder: fielder,
      sector: map['sector'] != null ? map['sector'] as int : null,
    );
  }
}
