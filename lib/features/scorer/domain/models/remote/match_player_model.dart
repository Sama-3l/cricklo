// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_player_stats_model.dart';

class MatchPlayerModel {
  final String id;
  final String playerId;
  final String name;
  final bool captain;
  final TeamRole teamRole;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final List<MatchPlayerStatsModel> stats;

  MatchPlayerModel({
    required this.id,
    required this.playerId,
    required this.name,
    required this.captain,
    required this.teamRole,
    required this.playerType,
    required this.batterType,
    required this.bowlerType,
    required this.stats,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'playerId': playerId,
      'name': name,
      'teamRole': teamRole.roleTitle,
      'playerType': playerType.name,
      'batterType': batterType?.name,
      'bowlerType': bowlerType?.title,
      'stats': stats.map((x) => x.toJson()).toList(),
    };
  }

  MatchPlayerEntity toEntity() {
    return MatchPlayerEntity(
      id: id,
      playerId: playerId,
      name: name,
      captain: captain,
      teamRole: teamRole,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      stats: stats.map((e) => e.toEntity()).toList(),
    );
  }

  factory MatchPlayerModel.fromEntity(MatchPlayerEntity entity) {
    return MatchPlayerModel(
      id: entity.id,
      playerId: entity.playerId,
      name: entity.name,
      captain: entity.captain,
      teamRole: entity.teamRole,
      playerType: entity.playerType,
      batterType: entity.batterType,
      bowlerType: entity.bowlerType,
      stats: entity.stats
          .map((e) => MatchPlayerStatsModel.fromEntity(e))
          .toList(),
    );
  }

  factory MatchPlayerModel.fromMap(Map<String, dynamic> map) {
    final data = map;

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
    final role = data['teamRole'];
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
      }
    }
    return MatchPlayerModel(
      id: map['id'] as String,
      playerId: map['playerId'] as String,
      name: map['name'] as String,
      captain: teamRole == TeamRole.captain,
      teamRole: teamRole,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      stats: (map['stats'] as List<dynamic>)
          .map<MatchPlayerStatsModel>((x) => MatchPlayerStatsModel.fromJson(x))
          .toList(),
    );
  }
}
