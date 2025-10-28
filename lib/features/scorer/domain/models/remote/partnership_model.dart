// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/partnership_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_player_model.dart';

class PartnershipModel {
  final MatchPlayerModel? player1;
  final MatchPlayerModel? player2;
  int runs;
  int balls;
  int inningsNumber;
  PartnershipModel({
    this.player1,
    this.player2,
    required this.runs,
    required this.balls,
    required this.inningsNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'player1': player1?.playerId,
      'player2': player2?.playerId,
      'player1Score': player1!.stats.last.runs,
      'player2Score': player2!.stats.last.runs,
      'player1Balls': player1!.stats.last.balls,
      'player2Balls': player2!.stats.last.balls,
      'runs': runs,
      'balls': balls,
      'inningsNumber': inningsNumber,
    };
  }

  PartnershipEntity toEntity() {
    return PartnershipEntity(
      runs: runs,
      balls: balls,
      player1: player1?.toEntity(),
      player2: player2?.toEntity(),
      inningsNumber: inningsNumber,
    );
  }

  factory PartnershipModel.fromEntity(PartnershipEntity entity) {
    return PartnershipModel(
      runs: entity.runs,
      balls: entity.balls,
      player1: entity.player1 == null
          ? null
          : MatchPlayerModel.fromEntity(entity.player1!),
      player2: entity.player1 == null
          ? null
          : MatchPlayerModel.fromEntity(entity.player2!),
      inningsNumber: entity.inningsNumber,
    );
  }

  factory PartnershipModel.fromJson(
    Map<String, dynamic> map,
    List<MatchPlayerModel> players,
  ) {
    final player1 = players
        .where((e) => e.playerId == map['player1'])
        .firstOrNull;
    final player2 = players
        .where((e) => e.playerId == map['player2'])
        .firstOrNull;
    return PartnershipModel(
      player1: player1,
      player2: player2,
      inningsNumber: map['inningsNumber'] as int,
      runs: map['runs'] as int,
      balls: map['balls'] as int,
    );
  }
}
