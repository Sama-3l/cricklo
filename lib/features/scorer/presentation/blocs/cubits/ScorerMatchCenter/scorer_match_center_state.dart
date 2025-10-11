part of 'scorer_match_center_cubit.dart';

@immutable
sealed class ScorerMatchCenterState {
  final int currentIndex;
  final Set<int> loadedTabs;
  final MatchCenterEntity? matchCenterEntity;

  const ScorerMatchCenterState({
    required this.currentIndex,
    required this.loadedTabs,
    this.matchCenterEntity,
  });

  ScorerMatchCenterState copyWith({
    int? currentIndex,
    Set<int>? loadedTabs,
    MatchCenterEntity? matchCenterEntity,
  }) {
    return ScorerMatchCenterUpdate(
      currentIndex: currentIndex ?? this.currentIndex,
      loadedTabs: loadedTabs ?? this.loadedTabs,
      matchCenterEntity: matchCenterEntity ?? this.matchCenterEntity,
    );
  }
}

final class ScorerMatchCenterUpdate extends ScorerMatchCenterState {
  const ScorerMatchCenterUpdate({
    required super.currentIndex,
    required super.loadedTabs,
    super.matchCenterEntity,
  });
}
