part of 'create_team_cubit.dart';

@immutable
sealed class CreateTeamState {
  final bool loading;

  const CreateTeamState({this.loading = false});
}

final class CreateTeamUpdate extends CreateTeamState {
  const CreateTeamUpdate({super.loading});
}
