// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/partnership_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_player_model.dart';

class PartnershipModel {
  final MatchPlayerModel? player1;
  final MatchPlayerModel? player2;
  int runs;
  int balls;
  PartnershipModel({
    this.player1,
    this.player2,
    required this.runs,
    required this.balls,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'player1': player1?.playerId,
      'player2': player2?.playerId,
      'runs': runs,
      'balls': balls,
    };
  }

  PartnershipEntity toEntity() {
    return PartnershipEntity(
      runs: runs,
      balls: balls,
      player1: player1?.toEntity(),
      player2: player2?.toEntity(),
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
      runs: map['runs'] as int,
      balls: map['balls'] as int,
    );
  }
}
