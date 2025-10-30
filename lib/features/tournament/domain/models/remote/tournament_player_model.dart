import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/models/remote/player_model.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_player_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_player_stats_model.dart';

class TournamentPlayerModel {
  final String id;
  final String playerId;
  final String name;
  final bool captain;
  final TeamRole teamRole;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final List<TournamentPlayerStatsModel> stats;

  TournamentPlayerModel({
    required this.id,
    required this.playerId,
    required this.name,
    required this.captain,
    required this.teamRole,
    required this.playerType,
    this.batterType,
    this.bowlerType,
    required this.stats,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'playerId': playerId,
      'name': name,
      'captain': captain,
      'teamRole': teamRole.roleTitle,
      'playerType': playerType.name,
      'batterType': batterType?.title,
      'bowlerType': bowlerType?.title,
      'stats': stats.map((x) => x.toJson()).toList(),
    };
  }

  TournamentPlayerEntity toEntity() {
    return TournamentPlayerEntity(
      id: id,
      playerId: playerId,
      name: name,
      captain: captain,
      teamRole: teamRole,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      stats: stats.map((x) => x.toEntity()).toList(),
    );
  }

  PlayerModel toPlayerModel() {
    return PlayerModel(
      id: id,
      playerId: playerId,
      name: name,
      captain: captain,
      teamRole: teamRole,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
      profilePic: '',
    );
  }

  factory TournamentPlayerModel.fromJson(Map<String, dynamic> map) {
    return TournamentPlayerModel(
      id: map['id'] as String,
      playerId: map['playerId'] as String,
      name: map['name'] as String,
      captain: map['captain'] as bool,
      teamRole: TeamRole.values
          .where((e) => e.roleTitle == map['teamRole'])
          .first,
      playerType: PlayerType.values
          .where((e) => e.name == map['playerType'])
          .first,
      batterType: BatterType.values
          .where((e) => e.name == map['batterType'])
          .first,
      bowlerType: BowlerType.values
          .where((e) => e.name == map['bowlerType'])
          .first,
      stats: List<TournamentPlayerStatsModel>.from(
        (map['stats'] as List<dynamic>).map<TournamentPlayerStatsModel>(
          (x) => TournamentPlayerStatsModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory TournamentPlayerModel.fromEntity(TournamentPlayerEntity entity) {
    return TournamentPlayerModel(
      id: entity.id,
      playerId: entity.playerId,
      name: entity.name,
      captain: entity.captain,
      teamRole: entity.teamRole,
      playerType: entity.playerType,
      batterType: entity.batterType,
      bowlerType: entity.bowlerType,
      stats: entity.stats
          .map((e) => TournamentPlayerStatsModel.fromEntity(e))
          .toList(),
    );
  }
}
