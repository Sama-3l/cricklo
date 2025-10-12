import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cricklo/features/matches/data/usecases/search_teams_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:meta/meta.dart';

part 'search_team_state.dart';

class SearchTeamCubit extends Cubit<SearchTeamState> {
  final SearchTeamsUseCase _searchTeamsUseCase;
  Timer? _debounce;

  String _lastQuery = "";
  int lastResponse = 1;

  SearchTeamCubit(this._searchTeamsUseCase)
    : super(const SearchTeamUpdate(searchResults: [], loading: false));

  void onQueryChanged(String query, {bool reset = true}) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(const SearchTeamUpdate(searchResults: []));
      return;
    }

    _debounce = Timer(Duration(milliseconds: reset ? 400 : 0), () async {
      if (reset) {
        _lastQuery = query;
      }

      try {
        emit(
          SearchTeamUpdate(searchResults: state.searchResults, loading: true),
        );

        final results = await _searchTeamsUseCase(query);

        results.fold(
          (_) {
            emit(
              SearchTeamUpdate(
                searchResults: state.searchResults,
                loading: false,
              ),
            );
          },
          (response) {
            // 👇 if no new players, just stop silently
            if (response.teams!.isEmpty) {
              lastResponse = 0;
              emit(
                SearchTeamUpdate(
                  searchResults: state.searchResults,
                  loading: false,
                ),
              );
              return;
            }

            // 👇 otherwise, add to the list
            final newList = reset
                ? response.teams!
                : [...state.searchResults, ...response.teams!];
            lastResponse = response.teams!.length;

            emit(SearchTeamUpdate(searchResults: newList, loading: false));
          },
        );
      } catch (e) {
        emit(
          SearchTeamUpdate(searchResults: state.searchResults, loading: false),
        );
      }
    });
  }

  /// call this when user scrolls near bottom
  void loadMore() {
    if (state.loading) return;
    if (lastResponse != 0) {
      onQueryChanged(_lastQuery, reset: false);
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
