part of 'account_page_cubit.dart';

// account_state.dart
class AccountPageState {
  final int selectedMainTab;
  final int selectedStatisticsTab;
  final UserEntity? userEntity;

  const AccountPageState({
    this.selectedMainTab = 0,
    this.selectedStatisticsTab = 0,
    this.userEntity,
  });

  AccountPageState copyWith({
    int? selectedMainTab,
    int? selectedStatisticsTab,
    UserEntity? userEntity,
  }) {
    return AccountPageState(
      selectedMainTab: selectedMainTab ?? this.selectedMainTab,
      selectedStatisticsTab:
          selectedStatisticsTab ?? this.selectedStatisticsTab,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}
