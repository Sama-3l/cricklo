import 'package:cricklo/features/follow/domain/entities/following_player_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_team_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_match_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_tournament_entity.dart';

class GetFollowingResponseEntity {
  final bool success;
  final List<FollowingPlayerEntity> players;
  final List<FollowingTeamEntity> teams;
  final List<FollowingMatchEntity> matches;
  final List<FollowingTournamentEntity> tournaments;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  const GetFollowingResponseEntity({
    required this.success,
    required this.players,
    required this.teams,
    required this.matches,
    required this.tournaments,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
