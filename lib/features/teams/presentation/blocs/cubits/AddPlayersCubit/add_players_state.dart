part of 'add_players_cubit.dart';

@immutable
sealed class AddPlayersState {
  final bool loading;
  final List<SearchUserEntity> players;

  const AddPlayersState({required this.loading, required this.players});
}

final class AddPlayersUpdate extends AddPlayersState {
  const AddPlayersUpdate({required super.loading, required super.players});
}
