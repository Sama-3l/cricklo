part of 'create_team_cubit.dart';

@immutable
sealed class CreateTeamState {
  final bool loading;
  final bool bannerLoading;
  final File? banner;
  final bool logoLoading;
  final File? logo;

  const CreateTeamState({
    this.loading = false,
    this.bannerLoading = false,
    this.banner,
    this.logo,
    this.logoLoading = false,
  });

  CreateTeamState copyWith({
    bool? loading,
    bool? bannerLoading,
    File? banner,
    bool? logoLoading,
    File? logo,
  }) {
    return CreateTeamUpdate(
      loading: loading ?? this.loading,
      bannerLoading: bannerLoading ?? this.bannerLoading,
      banner: banner ?? this.banner,
      logoLoading: logoLoading ?? this.logoLoading,
      logo: logo ?? this.logo,
    );
  }
}

final class CreateTeamUpdate extends CreateTeamState {
  const CreateTeamUpdate({
    super.loading,
    super.banner,
    super.bannerLoading,
    super.logo,
    super.logoLoading,
  });
}
