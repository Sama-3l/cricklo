import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:meta/meta.dart';

part 'team_page_state.dart';

class TeamPageCubit extends Cubit<TeamPageState> {
  TeamPageCubit()
    : super(
        TeamPageUpdate(
          selectedMainTab: 0,
          selectedPlayersTab: 0,
          selectedStatsTab: 0,
          selectedStatsTabTableType: 0,
        ),
      );

  init(TeamEntity team) {
    if (team.players.where((e) => e.teamRole != TeamRole.invited).isEmpty) {
      emit(
        TeamPageUpdate(
          selectedMainTab: state.selectedMainTab,
          selectedPlayersTab: 3,
          selectedStatsTab: state.selectedStatsTab,
          selectedStatsTabTableType: state.selectedStatsTabTableType,
        ),
      );
    }
  }

  void changeMainTab(int index) {
    emit(
      TeamPageUpdate(
        selectedMainTab: index,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: state.selectedStatsTabTableType,
      ),
    );
  }

  void changePlayersTab(int index) {
    emit(
      TeamPageUpdate(
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: index,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: state.selectedStatsTabTableType,
      ),
    );
  }

  void changeStatsTab(int index) {
    emit(
      TeamPageUpdate(
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: index,
        selectedStatsTabTableType: 0,
      ),
    );
  }

  void changeStatsTabTable(int index) {
    emit(
      TeamPageUpdate(
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: index,
      ),
    );
  }
}
