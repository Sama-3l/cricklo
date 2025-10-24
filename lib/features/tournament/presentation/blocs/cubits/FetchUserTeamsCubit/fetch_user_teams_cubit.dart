import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/account/data/usecases/get_teams_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:meta/meta.dart';

part 'fetch_user_teams_state.dart';

class FetchUserTeamsCubit extends Cubit<FetchUserTeamsState> {
  final GetTeamsUsecase _getTeamsUsecase;
  FetchUserTeamsCubit(this._getTeamsUsecase)
    : super(FetchUserTeamsUpdate(loading: false, teams: []));

  init() async {
    emit(state.copyWith(loading: true));
    final response = await _getTeamsUsecase(NoParams());
    response.fold(
      (_) {
        emit(state.copyWith(loading: false));
      },
      (response) {
        if (response.success) {
          emit(state.copyWith(loading: false, teams: response.teams));
        } else {
          emit(state.copyWith(loading: false));
        }
      },
    );
  }
}
