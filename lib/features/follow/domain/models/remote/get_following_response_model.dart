import 'package:cricklo/features/follow/domain/entities/get_following_response_entity.dart';
import 'package:cricklo/features/follow/domain/models/remote/following_match_model.dart';
import 'package:cricklo/features/follow/domain/models/remote/following_player_model.dart';
import 'package:cricklo/features/follow/domain/models/remote/following_team_model.dart';
import 'package:cricklo/features/follow/domain/models/remote/following_tournament_model.dart';

class GetFollowingResponseModel {
  final bool success;
  final List<FollowingPlayerModel> players;
  final List<FollowingTeamModel> teams;
  final List<FollowingMatchModel> matches;
  final List<FollowingTournamentModel> tournaments;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  const GetFollowingResponseModel({
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

  /// ✅ Convert Model → Entity
  GetFollowingResponseEntity toEntity() {
    return GetFollowingResponseEntity(
      success: success,
      players: players.map((e) => e.toEntity()).toList(),
      teams: teams.map((e) => e.toEntity()).toList(),
      matches: matches.map((e) => e.toEntity()).toList(),
      tournaments: tournaments.map((e) => e.toEntity()).toList(),
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  /// ✅ From JSON → Model
  factory GetFollowingResponseModel.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] ?? {};
    return GetFollowingResponseModel(
      success: json['success'] ?? false,
      players: (payload['players'] as List<dynamic>? ?? [])
          .map((e) => FollowingPlayerModel.fromJson(e))
          .toList(),
      teams: (payload['teams'] as List<dynamic>? ?? [])
          .map((e) => FollowingTeamModel.fromJson(e))
          .toList(),
      matches: (payload['matches'] as List<dynamic>? ?? [])
          .map((e) => FollowingMatchModel.fromJson(e))
          .toList(),
      tournaments: (payload['tournaments'] as List<dynamic>? ?? [])
          .map((e) => FollowingTournamentModel.fromJson(e))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as int?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  /// ✅ Convert Model → JSON (for debugging or caching)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'payload': {
        'players': players.map((e) => e.toJson()).toList(),
        'teams': teams.map((e) => e.toJson()).toList(),
        'matches': matches.map((e) => e.toJson()).toList(),
        'tournaments': tournaments.map((e) => e.toJson()).toList(),
      },
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }
}
