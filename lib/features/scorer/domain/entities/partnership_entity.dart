// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';

class PartnershipEntity {
  final MatchPlayerEntity? player1;
  final MatchPlayerEntity? player2;
  final int runs;
  final int balls;
  PartnershipEntity({
    this.player1,
    this.player2,
    required this.runs,
    required this.balls,
  });
}
