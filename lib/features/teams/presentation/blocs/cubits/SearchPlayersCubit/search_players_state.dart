part of 'search_players_cubit.dart';

@immutable
sealed class SearchPlayersState {
  final bool loading;
  final List<SearchUserEntity> searchResults;

  const SearchPlayersState({this.loading = false, required this.searchResults});
}

final class SearchPlayersInitial extends SearchPlayersState {
  const SearchPlayersInitial({super.loading, required super.searchResults});
}
