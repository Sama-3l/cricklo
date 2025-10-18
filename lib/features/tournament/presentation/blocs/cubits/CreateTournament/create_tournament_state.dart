part of 'create_tournament_cubit.dart';

@immutable
sealed class CreateTournamentState {
  final bool loading;
  final bool bannerLoading;
  final File? banner;

  const CreateTournamentState({
    required this.loading,
    required this.bannerLoading,
    required this.banner,
  });

  CreateTournamentUpdate copyWith({
    bool? loading,
    bool? bannerLoading,
    File? banner,
  }) {
    return CreateTournamentUpdate(
      loading: loading ?? this.loading,
      bannerLoading: bannerLoading ?? this.bannerLoading,
      banner: banner ?? this.banner,
    );
  }
}

final class CreateTournamentUpdate extends CreateTournamentState {
  const CreateTournamentUpdate({
    required super.loading,
    required super.bannerLoading,
    required super.banner,
  });
}
