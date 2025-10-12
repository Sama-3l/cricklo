part of 'create_match_cubit.dart';

@immutable
sealed class CreateMatchState {
  final bool loading;

  const CreateMatchState({this.loading = false});
}

final class CreateMatchInitial extends CreateMatchState {
  const CreateMatchInitial({super.loading});
}
