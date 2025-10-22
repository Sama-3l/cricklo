import 'package:bloc/bloc.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:meta/meta.dart';

part 'tournament_state.dart';

class TournamentCubit extends Cubit<TournamentState> {
  TournamentCubit()
    : super(
        TournamentUpdate(
          tournamentEntity: null,
          selectedMainTab: 0,
          selectedStatsTab: 0,
          selectedStatsTabTableType: 0,
        ),
      );

  init(TournamentEntity tournamentEntity) {
    emit(state.copyWith(tournamentEntity: tournamentEntity));
  }

  void changeMainTab(int index) {
    emit(state.copyWith(selectedMainTab: index));
  }

  void changeStatsTab(int index) {
    emit(state.copyWith(selectedStatsTab: index, selectedStatsTabTableType: 0));
  }

  void changeStatsTabTable(int index) {
    emit(state.copyWith(selectedStatsTabTableType: index));
  }
}
