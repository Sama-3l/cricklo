// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';

class SearchUserModel {
  final String playerId;
  final String name;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;

  SearchUserModel({
    required this.playerId,
    required this.name,
    required this.playerType,
    this.batterType,
    this.bowlerType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'playerId': playerId,
      'name': name,
      'playerType': playerType.name,
      'batterType': batterType?.title,
      'bowlerType': bowlerType?.title,
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
      playerId: data['playerId'] as String,
      name: data['name'] as String,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }

  factory SearchUserModel.fromEntity(SearchUserEntity entity) {
    return SearchUserModel(
      playerId: entity.playerId,
      name: entity.name,
      playerType: entity.playerType,
    );
  }

  SearchUserEntity toEntity() {
    return SearchUserEntity(
      playerId: playerId,
      name: name,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }
}
