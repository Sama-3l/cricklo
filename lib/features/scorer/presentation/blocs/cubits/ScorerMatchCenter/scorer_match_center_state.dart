part of 'scorer_match_center_cubit.dart';

@immutable
sealed class ScorerMatchCenterState {
  final int currentIndex;
  final Set<int> loadedTabs;

  const ScorerMatchCenterState({
    required this.currentIndex,
    required this.loadedTabs,
  });

  ScorerMatchCenterState copyWith({int? currentIndex, Set<int>? loadedTabs}) {
    return ScorerMatchCenterUpdate(
      currentIndex: currentIndex ?? this.currentIndex,
      loadedTabs: loadedTabs ?? this.loadedTabs,
    );
  }
}

final class ScorerMatchCenterUpdate extends ScorerMatchCenterState {
  const ScorerMatchCenterUpdate({
    required super.currentIndex,
    required super.loadedTabs,
  });
}
