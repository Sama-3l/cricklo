part of 'team_page_cubit.dart';

@immutable
sealed class TeamPageState {
  final int selectedMainTab;
  final int selectedPlayersTab;
  final int selectedStatsTab;
  final int selectedStatsTabTableType;

  const TeamPageState({
    required this.selectedMainTab,
    required this.selectedPlayersTab,
    required this.selectedStatsTab,
    required this.selectedStatsTabTableType,
  });
}

final class TeamPageUpdate extends TeamPageState {
  const TeamPageUpdate({
    required super.selectedMainTab,
    required super.selectedPlayersTab,
    required super.selectedStatsTab,
    required super.selectedStatsTabTableType,
  });
}
