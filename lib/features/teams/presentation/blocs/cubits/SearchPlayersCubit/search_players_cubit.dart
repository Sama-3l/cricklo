import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cricklo/features/teams/data/usecases/search_players_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:meta/meta.dart';

part 'search_players_state.dart';

class SearchPlayersCubit extends Cubit<SearchPlayersState> {
  final SearchPlayersUsecase _searchPlayersUsecase;
  Timer? _debounce;

  SearchPlayersCubit(this._searchPlayersUsecase)
    : super(const SearchPlayersInitial(searchResults: []));

  void onQueryChanged(String query) {
    // Cancel previous debounce timer if still active
    _debounce?.cancel();

    // If query is empty, clear results immediately
    if (query.trim().isEmpty) {
      emit(const SearchPlayersInitial(searchResults: []));
      return;
    }

    // Start new debounce timer (delay 400ms)
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      try {
        emit(
          SearchPlayersInitial(
            searchResults: state.searchResults,
            loading: true,
          ),
        );
        final results = await _searchPlayersUsecase(query);
        results.fold(
          (_) {
            emit(SearchPlayersInitial(searchResults: [], loading: false));
          },
          (response) {
            emit(
              SearchPlayersInitial(
                searchResults: response.users,
                loading: false,
              ),
            );
          },
        );
      } catch (e) {
        emit(SearchPlayersInitial(searchResults: [], loading: false));
      }
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
