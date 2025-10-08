import 'package:bloc/bloc.dart';
import 'package:cricklo/features/teams/data/entities/invite_player_usecase_entity.dart';
import 'package:cricklo/features/teams/data/usecases/invite_player_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:meta/meta.dart';

part 'add_players_state.dart';

class AddPlayersCubit extends Cubit<AddPlayersState> {
  final InvitePlayerUsecase _invitePlayerUsecase;

  AddPlayersCubit(this._invitePlayerUsecase)
    : super(AddPlayersUpdate(players: [], loading: false));

  init(List<PlayerEntity> players) =>
      emit(AddPlayersUpdate(loading: state.loading, players: []));

  changeIndex(int index) =>
      emit(AddPlayersUpdate(loading: state.loading, players: state.players));

  playersAdded(List<SearchUserEntity> players) =>
      emit(AddPlayersUpdate(loading: state.loading, players: players));

  removePlayer(String playerId) {
    state.players.removeWhere((e) => e.playerId == playerId);
    emit(AddPlayersUpdate(loading: state.loading, players: state.players));
  }

  sendInvites(TeamEntity team) async {
    emit(AddPlayersUpdate(loading: true, players: state.players));
    final response = await _invitePlayerUsecase(
      InvitePlayerUsecaseEntity(players: state.players, teamId: team.id),
    );
    response.fold((_) {}, (response) {
      if (response.success) {
        emit(AddPlayersUpdate(loading: false, players: state.players));
      } else {
        emit(AddPlayersUpdate(loading: false, players: state.players));
      }
    });
    emit(AddPlayersUpdate(loading: false, players: state.players));
  }
}
