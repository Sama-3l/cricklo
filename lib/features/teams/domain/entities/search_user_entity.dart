// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';

class SearchUserEntity {
  final String id;
  final String playerId;
  final String name;
  final String? profilePic;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final InviteStatus? inviteStatus;

  SearchUserEntity({
    required this.id,
    required this.playerId,
    required this.name,
    this.profilePic,
    required this.playerType,
    this.batterType,
    this.bowlerType,
    this.inviteStatus,
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

  SearchUserEntity copyWith({
    String? id,
    String? playerId,
    String? name,
    String? profilePic,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
    InviteStatus? inviteStatus,
  }) {
    return SearchUserEntity(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
      inviteStatus: inviteStatus ?? this.inviteStatus,
    );
  }
}
