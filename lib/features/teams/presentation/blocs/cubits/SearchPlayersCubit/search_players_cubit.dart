import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cricklo/features/teams/data/entities/search_player_usecase_entity.dart';
import 'package:cricklo/features/teams/data/usecases/search_players_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:flutter/material.dart';

part 'search_players_state.dart';

class SearchPlayersCubit extends Cubit<SearchPlayersState> {
  final SearchPlayersUsecase _searchPlayersUsecase;
  Timer? _debounce;

  int _page = 1;
  String _lastQuery = "";
  int lastResponse = 1;

  SearchPlayersCubit(this._searchPlayersUsecase)
    : super(const SearchPlayersInitial(searchResults: [], loading: false));

  void onQueryChanged(String query, {bool reset = true}) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(const SearchPlayersInitial(searchResults: []));
      return;
    }

    _debounce = Timer(Duration(milliseconds: reset ? 400 : 0), () async {
      if (reset) {
        _page = 1;
        _lastQuery = query;
      }

      try {
        emit(
          SearchPlayersInitial(
            searchResults: state.searchResults,
            loading: true,
          ),
        );

        final results = await _searchPlayersUsecase(
          SearchPlayerUsecaseEntity(query: query, page: _page),
        );

        results.fold(
          (_) {
            emit(
              SearchPlayersInitial(
                searchResults: state.searchResults,
                loading: false,
              ),
            );
          },
          (response) {
            // 👇 if no new players, just stop silently
            if (response.users.isEmpty) {
              lastResponse = 0;
              emit(
                SearchPlayersInitial(
                  searchResults: state.searchResults,
                  loading: false,
                ),
              );
              return;
            }

            // 👇 otherwise, add to the list
            final newList = reset
                ? response.users
                : [...state.searchResults, ...response.users];
            lastResponse = response.users.length;
            _page++; // increment for next load

            emit(SearchPlayersInitial(searchResults: newList, loading: false));
          },
        );
      } catch (e) {
        emit(
          SearchPlayersInitial(
            searchResults: state.searchResults,
            loading: false,
          ),
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
