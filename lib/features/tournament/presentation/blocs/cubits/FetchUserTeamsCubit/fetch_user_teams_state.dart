part of 'fetch_user_teams_cubit.dart';

@immutable
sealed class FetchUserTeamsState {
  final bool loading;
  final List<TeamEntity> teams;

  const FetchUserTeamsState({required this.loading, required this.teams});

  FetchUserTeamsUpdate copyWith({bool? loading, List<TeamEntity>? teams}) {
    return FetchUserTeamsUpdate(
      loading: loading ?? this.loading,
      teams: teams ?? this.teams,
    );
  }
}

final class FetchUserTeamsUpdate extends FetchUserTeamsState {
  const FetchUserTeamsUpdate({required super.loading, required super.teams});
}
