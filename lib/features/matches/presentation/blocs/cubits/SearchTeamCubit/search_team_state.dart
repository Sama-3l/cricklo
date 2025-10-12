part of 'search_team_cubit.dart';

@immutable
sealed class SearchTeamState {
  final bool loading;
  final List<TeamEntity> searchResults;

  const SearchTeamState({this.loading = false, required this.searchResults});
}

final class SearchTeamUpdate extends SearchTeamState {
  const SearchTeamUpdate({super.loading, required super.searchResults});
}
