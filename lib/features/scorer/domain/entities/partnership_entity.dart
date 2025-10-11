// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';

class PartnershipEntity {
  final MatchPlayerEntity? player1;
  final MatchPlayerEntity? player2;
  int runs;
  int balls;
  PartnershipEntity({
    this.player1,
    this.player2,
    required this.runs,
    required this.balls,
  });

  PartnershipEntity copyWith({
    MatchPlayerEntity? player1,
    MatchPlayerEntity? player2,
    int? runs,
    int? balls,
  }) {
    return PartnershipEntity(
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      runs: runs ?? this.runs,
      balls: balls ?? this.balls,
    );
  }
}
