// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class PlayerEntity {
  final String? id;
  final String playerId;
  final String? profilePic;
  final String name;
  final bool captain;
  final TeamRole teamRole;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;

  PlayerEntity({
    required this.id,
    required this.playerId,
    required this.name,
    required this.profilePic,
    required this.captain,
    required this.teamRole,
    required this.playerType,
    required this.batterType,
    required this.bowlerType,
  });

  PlayerEntity copyWith({
    String? id,
    String? playerId,
    String? name,
    bool? captain,
    TeamRole? teamRole,
    String? profilePic,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
  }) {
    return PlayerEntity(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      name: name ?? this.name,
      captain: captain ?? this.captain,
      profilePic: profilePic ?? this.profilePic,
      teamRole: teamRole ?? this.teamRole,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
    );
  }
}
