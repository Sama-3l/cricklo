part of 'team_page_cubit.dart';

@immutable
sealed class TeamPageState {
  final bool loading;
  final TeamEntity? team;
  final int selectedMainTab;
  final int selectedPlayersTab;
  final int selectedStatsTab;
  final int selectedStatsTabTableType;
  final bool follow;

  const TeamPageState({
    this.loading = false,
    required this.team,
    required this.selectedMainTab,
    required this.selectedPlayersTab,
    required this.selectedStatsTab,
    required this.selectedStatsTabTableType,
    required this.follow,
  });
}

final class TeamPageUpdate extends TeamPageState {
  const TeamPageUpdate({
    required super.selectedMainTab,
    required super.selectedPlayersTab,
    required super.selectedStatsTab,
    required super.selectedStatsTabTableType,
    super.loading,
    required super.team,
    required super.follow,
  });
}
