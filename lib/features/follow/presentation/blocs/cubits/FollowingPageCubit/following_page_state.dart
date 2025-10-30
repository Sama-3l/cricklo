part of 'following_page_cubit.dart';

@immutable
sealed class FollowingPageState {
  final bool loading;
  final List<FollowingPlayerEntity> players;
  final List<FollowingTeamEntity> teams;
  final List<FollowingMatchEntity> matches;
  final List<TournamentEntity> tournaments;

  FollowingPageUpdate copyWith({
    bool? loading,
    List<FollowingPlayerEntity>? players,
    List<FollowingTeamEntity>? teams,
    List<FollowingMatchEntity>? matches,
    List<TournamentEntity>? tournaments,
  }) {
    return FollowingPageUpdate(
      players: players ?? this.players,
      teams: teams ?? this.teams,
      matches: matches ?? this.matches,
      tournaments: tournaments ?? this.tournaments,
      loading: loading ?? this.loading,
    );
  }

  const FollowingPageState({
    this.loading = false,
    required this.players,
    required this.teams,
    required this.matches,
    required this.tournaments,
  });
}

final class FollowingPageUpdate extends FollowingPageState {
  const FollowingPageUpdate({
    required super.players,
    required super.teams,
    required super.matches,
    required super.tournaments,
    super.loading,
  });
}
