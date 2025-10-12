part of 'main_app_cubit.dart';

@immutable
sealed class MainAppState {
  final int currentIndex;
  final bool showOptions;
  final bool loading;
  final UserEntity? user;
  final List<MatchEntity> matches;

  const MainAppState({
    required this.currentIndex,
    required this.showOptions,
    this.loading = false,
    this.user,
    required this.matches,
  });
}

final class UpdateIndex extends MainAppState {
  const UpdateIndex({
    required super.currentIndex,
    required super.showOptions,
    required super.matches,
    super.loading,
    super.user,
  });
}
