part of 'add_team_to_group_cubit.dart';

@immutable
sealed class AddTeamToGroupState {
  final bool loading;
  final List<TournamentTeamEntity> searchResults;

  const AddTeamToGroupState({
    this.loading = false,
    required this.searchResults,
  });
}

final class AddTeamToGroupUpdate extends AddTeamToGroupState {
  const AddTeamToGroupUpdate({required super.searchResults, super.loading});
}
