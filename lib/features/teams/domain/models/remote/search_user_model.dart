// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';

class SearchUserModel {
  final String id;
  final String playerId;
  final String name;
  final String? profilePic;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final InviteStatus? inviteStatus;

  SearchUserModel({
    required this.id,
    required this.playerId,
    required this.name,
    this.profilePic,
    required this.playerType,
    this.batterType,
    this.bowlerType,
    this.inviteStatus,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'playerId': playerId,
      'name': name,
      'playerType': playerType.name,
      'batterType': batterType?.title,
      'bowlerType': bowlerType?.title,
      'inviteStatus': inviteStatus,
    };
  }

  factory SearchUserModel.fromJson(Map<String, dynamic> json) {
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
    return SearchUserModel(
      id: data['id'] as String? ?? data['userId'] as String,
      playerId: data['playerId'] as String? ?? data['profileId'] as String,
      name: data['name'] as String? ?? data['name'] as String,
      profilePic: data['profilePicture'] as String?,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      inviteStatus: data['status'] == null
          ? null
          : InviteStatus.values
                .where((e) => e.title == data['status'] as String)
                .first,
    );
  }

  factory SearchUserModel.fromEntity(SearchUserEntity entity) {
    return SearchUserModel(
      id: entity.id,
      playerId: entity.playerId,
      name: entity.name,
      playerType: entity.playerType,
      inviteStatus: entity.inviteStatus,
      profilePic: entity.profilePic,
    );
  }

  SearchUserEntity toEntity() {
    return SearchUserEntity(
      id: id,
      playerId: playerId,
      name: name,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      inviteStatus: inviteStatus,
      profilePic: profilePic,
    );
  }
}
