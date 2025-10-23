// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_player_stats_entity.dart';

class TournamentPlayerEntity {
  final String id;
  final String playerId;
  final String name;
  final bool captain;
  final TeamRole teamRole;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;
  final List<TournamentPlayerStatsEntity> stats;

  TournamentPlayerEntity({
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
}
