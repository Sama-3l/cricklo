part of 'main_app_cubit.dart';

@immutable
sealed class MainAppState {
  final int currentIndex;
  final bool showOptions;
  final bool loading;
  final bool matchLoading;
  final bool tournamentLoading;
  final UserEntity? user;
  final List<MatchEntity> matches;
  final List<TournamentEntity> tournaments;

  const MainAppState({
    required this.currentIndex,
    required this.showOptions,
    required this.matchLoading,
    required this.tournamentLoading,
    this.loading = false,
    this.user,
    required this.matches,
    required this.tournaments,
  });
}

final class UpdateIndex extends MainAppState {
  const UpdateIndex({
    required super.matchLoading,
    required super.tournamentLoading,
    required super.currentIndex,
    required super.showOptions,
    required super.matches,
    required super.tournaments,
    super.loading,
    super.user,
  });
}
