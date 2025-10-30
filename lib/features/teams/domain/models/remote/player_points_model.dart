// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/player_points_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/player_model.dart';

class PlayerPointsModel {
  final PlayerModel player;
  final int points;

  PlayerPointsModel({required this.player, required this.points});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'player': player.toJson(), 'points': points};
  }

  factory PlayerPointsModel.fromJson(
    Map<String, dynamic> map,
    List<PlayerModel> players,
  ) {
    final player = players
        .where((e) => e.playerId == map['player']['profileId'])
        .first;
    return PlayerPointsModel(player: player, points: map['mvpPoints'] as int);
  }

  PlayerPointsEntity toEntity() {
    return PlayerPointsEntity(player: player.toEntity(), points: points);
  }

  factory PlayerPointsModel.fromEntity(PlayerPointsEntity entity) {
    return PlayerPointsModel(
      player: PlayerModel.fromEntity(entity.player),
      points: entity.points,
    );
  }
}
