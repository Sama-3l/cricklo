// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_stats_entity.dart';

class MatchPlayerEntity {
  final String id;
  final String playerId;
  final String name;
  final bool captain;
  final TeamRole teamRole;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final MatchPlayerStatsEntity stats;

  MatchPlayerEntity({
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

  MatchPlayerEntity copyWith({
    String? id,
    String? playerId,
    String? name,
    bool? captain,
    TeamRole? teamRole,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
    MatchPlayerStatsEntity? stats,
  }) {
    return MatchPlayerEntity(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      name: name ?? this.name,
      captain: captain ?? this.captain,
      teamRole: teamRole ?? this.teamRole,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
      stats: stats != null ? stats.copyWith() : this.stats.copyWith(),
    );
  }
}
