part of 'profile_page_cubit.dart';

@immutable
sealed class ProfilePageState {
  final bool follow;
  final bool loading;
  final int selectedMainTab;
  final int selectedStatisticsTab;
  final UserEntity? userEntity;
  final bool teamsLoading;
  final List<TeamEntity> teams;

  const ProfilePageState({
    this.follow = false,
    this.loading = false,
    this.selectedMainTab = 0,
    this.selectedStatisticsTab = 0,
    this.userEntity,
    this.teamsLoading = false,
    required this.teams,
  });

  ProfilePageUpdate copyWith({
    bool? loading,
    bool? follow,
    int? selectedMainTab,
    int? selectedStatisticsTab,
    UserEntity? userEntity,
    bool? teamsLoading,
    List<TeamEntity>? teams,
  }) {
    return ProfilePageUpdate(
      loading: loading ?? this.loading,
      follow: follow ?? this.follow,
      teams: teams ?? this.teams,
      selectedMainTab: selectedMainTab ?? this.selectedMainTab,
      selectedStatisticsTab:
          selectedStatisticsTab ?? this.selectedStatisticsTab,
      teamsLoading: teamsLoading ?? this.teamsLoading,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}

final class ProfilePageUpdate extends ProfilePageState {
  const ProfilePageUpdate({
    required super.teams,
    super.loading,
    super.follow,
    super.selectedMainTab,
    super.selectedStatisticsTab,
    super.userEntity,
    super.teamsLoading,
  });
}
