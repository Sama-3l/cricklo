part of 'tournament_cubit.dart';

@immutable
sealed class TournamentState {
  final bool loading;
  final TournamentEntity? tournamentEntity;
  final bool applied;
  final int selectedMainTab;
  final int selectedStatsTab;
  final int selectedStatsTabTableType;

  const TournamentState({
    this.loading = false,
    this.applied = false,
    required this.tournamentEntity,
    required this.selectedMainTab,
    required this.selectedStatsTab,
    required this.selectedStatsTabTableType,
  });

  TournamentUpdate copyWith({
    bool? loading,
    bool? applied,
    TournamentEntity? tournamentEntity,
    int? selectedMainTab,
    int? selectedStatsTab,
    int? selectedStatsTabTableType,
  }) {
    return TournamentUpdate(
      loading: loading ?? this.loading,
      applied: applied ?? this.applied,
      tournamentEntity: tournamentEntity ?? this.tournamentEntity,
      selectedMainTab: selectedMainTab ?? this.selectedMainTab,
      selectedStatsTab: selectedStatsTab ?? this.selectedStatsTab,
      selectedStatsTabTableType:
          selectedStatsTabTableType ?? this.selectedStatsTabTableType,
    );
  }
}

final class TournamentUpdate extends TournamentState {
  const TournamentUpdate({
    super.loading,
    super.applied,
    required super.tournamentEntity,
    required super.selectedMainTab,
    required super.selectedStatsTab,
    required super.selectedStatsTabTableType,
  });
}
