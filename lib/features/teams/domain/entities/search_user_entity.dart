// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';

class SearchUserEntity {
  final String id;
  final String playerId;
  final String name;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;

  SearchUserEntity({
    required this.id,
    required this.playerId,
    required this.name,
    required this.playerType,
    this.batterType,
    this.bowlerType,
  });

  PlayerEntity toPlayerEntity() {
    return PlayerEntity(
      id: id,
      profilePic: null,
      playerId: playerId,
      name: name,
      captain: false,
      teamRole: TeamRole.invited,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }
}
