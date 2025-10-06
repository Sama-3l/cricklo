import 'package:bloc/bloc.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:meta/meta.dart';

part 'add_players_state.dart';

class AddPlayersCubit extends Cubit<AddPlayersState> {
  AddPlayersCubit() : super(AddPlayersUpdate(players: [], loading: false));

  init(List<PlayerEntity> players) =>
      emit(AddPlayersUpdate(loading: state.loading, players: players));

  changeIndex(int index) =>
      emit(AddPlayersUpdate(loading: state.loading, players: state.players));

  playersAdded(List<PlayerEntity> players) =>
      emit(AddPlayersUpdate(loading: state.loading, players: players));
}
