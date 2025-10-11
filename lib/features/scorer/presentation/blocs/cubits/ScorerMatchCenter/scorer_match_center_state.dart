part of 'scorer_match_center_cubit.dart';

@immutable
sealed class ScorerMatchCenterState {
  final int currentIndex;
  final MatchEntity? matchEntity;
  final Set<int> loadedTabs;
  final MatchCenterEntity? matchCenterEntity;

  const ScorerMatchCenterState({
    required this.currentIndex,
    required this.loadedTabs,
    required this.matchEntity,

    this.matchCenterEntity,
  });

  ScorerMatchCenterState copyWith({
    int? currentIndex,
    Set<int>? loadedTabs,
    MatchCenterEntity? matchCenterEntity,
    List<MatchCenterEntity>? undoHistory,
    MatchEntity? matchEntity,
  }) {
    return ScorerMatchCenterUpdate(
      currentIndex: currentIndex ?? this.currentIndex,
      loadedTabs: loadedTabs ?? this.loadedTabs,
      matchCenterEntity: matchCenterEntity ?? this.matchCenterEntity,
      matchEntity: matchEntity ?? this.matchEntity,
    );
  }
}

final class ScorerMatchCenterUpdate extends ScorerMatchCenterState {
  const ScorerMatchCenterUpdate({
    required super.currentIndex,
    required super.loadedTabs,
    required super.matchEntity,
    super.matchCenterEntity,
  });
}
