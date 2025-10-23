import 'package:bloc/bloc.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:meta/meta.dart';

part 'add_team_to_group_state.dart';

class AddTeamToGroupCubit extends Cubit<AddTeamToGroupState> {
  AddTeamToGroupCubit()
    : super(AddTeamToGroupUpdate(searchResults: [], loading: false));

  init(List<TournamentTeamEntity> teams) {
    emit(AddTeamToGroupUpdate(searchResults: teams, loading: false));
  }

  void searchTeams(String query, List<TournamentTeamEntity> allTeams) {
    if (query.trim().isEmpty) {
      emit(AddTeamToGroupUpdate(searchResults: allTeams));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filtered = allTeams.where((teamEntity) {
      final name = teamEntity.name.toLowerCase();
      final id = teamEntity.id.toLowerCase();
      return name.contains(lowerQuery) || id.contains(lowerQuery);
    }).toList();

    emit(AddTeamToGroupUpdate(searchResults: filtered));
  }
}
