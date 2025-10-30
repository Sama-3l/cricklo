import 'package:cricklo/features/teams/domain/entities/player_entity.dart';

class PlayerPointsEntity {
  final PlayerEntity player;
  final int points;

  PlayerPointsEntity({required this.player, required this.points});
}
