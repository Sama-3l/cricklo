part of 'scorer_match_center_cubit.dart';

@immutable
sealed class ScorerMatchCenterState {
  final int currentIndex;
  final bool loading;
  final MatchEntity? matchEntity;
  final Set<int> loadedTabs;
  final bool spectator;
  final MatchCenterEntity? matchCenterEntity;

  const ScorerMatchCenterState({
    required this.loading,
    required this.currentIndex,
    required this.loadedTabs,
    required this.matchEntity,
    required this.spectator,
    this.matchCenterEntity,
  });

  ScorerMatchCenterState copyWith({
    int? currentIndex,
    Set<int>? loadedTabs,
    bool? spectator,
    bool? loading,
    MatchCenterEntity? matchCenterEntity,
    List<MatchCenterEntity>? undoHistory,
    MatchEntity? matchEntity,
  }) {
    return ScorerMatchCenterUpdate(
      currentIndex: currentIndex ?? this.currentIndex,
      loading: loading ?? this.loading,
      loadedTabs: loadedTabs ?? this.loadedTabs,
      spectator: spectator ?? this.spectator,
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
    required super.spectator,
    required super.loading,
    super.matchCenterEntity,
  });
}
