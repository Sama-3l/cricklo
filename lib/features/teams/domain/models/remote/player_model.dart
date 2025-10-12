// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';

class PlayerModel {
  final String? id;
  final String playerId;
  final String name;
  final bool captain;
  final TeamRole teamRole;
  final String? profilePic;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;

  PlayerModel({
    required this.id,
    required this.playerId,
    required this.name,
    required this.captain,
    required this.teamRole,
    required this.profilePic,
    required this.playerType,
    required this.batterType,
    required this.bowlerType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'playerId': playerId,
      'name': name,
      'captain': captain,
      'teamRole': teamRole.roleTitle,
      'profilePic': profilePic,
      'playerType': playerType.name,
      'batterType': batterType?.title,
      'bowlerType': bowlerType?.title,
    };
  }

  PlayerEntity toEntity() {
    return PlayerEntity(
      id: id,
      playerId: playerId,
      profilePic: profilePic,
      name: name,
      captain: captain,
      teamRole: teamRole,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }

  factory PlayerModel.fromEntity(PlayerEntity player) {
    return PlayerModel(
      id: player.id,
      playerId: player.playerId,
      name: player.name,
      captain: player.captain,
      teamRole: player.teamRole,
      profilePic: player.profilePic,
      playerType: player.playerType,
      batterType: player.batterType,
      bowlerType: player.bowlerType,
    );
  }

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    final data = json;

    PlayerType playerType;
    switch ((data['playerType'] ?? '').toString().toLowerCase()) {
      case 'batsman':
        playerType = PlayerType.batter;
        break;
      case 'bowler':
        playerType = PlayerType.bowler;
        break;
      case 'allrounder':
      default:
        playerType = PlayerType.allRounder;
    }

    // BatterType
    BatterType? batterType;

    final batsmen = data['batsmanType'];

    if (batsmen != null) {
      switch (batsmen.toUpperCase()) {
        case 'LEFT_HANDED':
          batterType = BatterType.leftHand;
          break;
        case 'RIGHT_HANDED':
          batterType = BatterType.rightHand;
          break;
        default:
          batterType = null;
          break;
      }
    }

    // BowlerType
    BowlerType? bowlerType;
    final bowler = data['bowlerType'];
    if (bowler != null) {
      switch (bowler.toUpperCase()) {
        case 'LEFT_ARM_LEGSPIN':
          bowlerType = BowlerType.leftArmSpin;
          break;
        case 'LEFT_ARM_FAST':
          bowlerType = BowlerType.leftArmPace;
          break;
        case 'RIGHT_ARM_LEGSPIN':
          bowlerType = BowlerType.rightArmSpin;
          break;
        case 'RIGHT_ARM_FAST':
          bowlerType = BowlerType.rightArmPace;
          break;
        default:
          bowlerType = null;
          break;
      }
    }
    TeamRole teamRole = TeamRole.invited;
    final role = data['playerRole'];
    if (role != null) {
      switch (role) {
        case 'Active_Squad':
          teamRole = TeamRole.active;
          break;
        case 'Captain':
          teamRole = TeamRole.captain;
          break;
        case 'Substitute':
          teamRole = TeamRole.sub;
          break;
        case 'Member':
          teamRole = TeamRole.member;
          break;
      }
    }
    return PlayerModel(
      id: json['id'] as String?,
      playerId: json['playerId'] as String,
      name: json['name'] ?? json['playerName'] as String,
      captain: teamRole == TeamRole.captain,
      teamRole: teamRole,
      profilePic: json['profilePic'] != null
          ? json['profilePic'] as String
          : null,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }
}
