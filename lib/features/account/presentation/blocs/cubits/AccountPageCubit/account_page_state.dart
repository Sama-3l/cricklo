part of 'account_page_cubit.dart';

// account_state.dart
class AccountPageState {
  final int selectedMainTab;
  final int selectedStatisticsTab;
  final UserEntity? userEntity;
  final bool teamsLoading;
  final List<TeamEntity> teams;

  const AccountPageState({
    this.selectedMainTab = 0,
    this.selectedStatisticsTab = 0,
    this.userEntity,
    this.teamsLoading = false,
    required this.teams,
  });

  AccountPageState copyWith({
    int? selectedMainTab,
    int? selectedStatisticsTab,
    UserEntity? userEntity,
    bool? teamsLoading,
    List<TeamEntity>? teams,
  }) {
    return AccountPageState(
      selectedMainTab: selectedMainTab ?? this.selectedMainTab,
      selectedStatisticsTab:
          selectedStatisticsTab ?? this.selectedStatisticsTab,
      userEntity: userEntity ?? this.userEntity,
      teamsLoading: teamsLoading ?? this.teamsLoading,
      teams: teams ?? this.teams,
    );
  }
}
