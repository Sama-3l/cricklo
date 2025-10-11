import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/account/data/usecases/get_teams_usecase.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

part 'account_page_state.dart';

class AccountCubit extends Cubit<AccountPageState> {
  final GetTeamsUsecase _getTeamsUsecase;
  AccountCubit(this._getTeamsUsecase)
    : super(const AccountPageState(teams: []));

  init(UserEntity? userEntity) async {
    emit(state.copyWith(teamsLoading: true, userEntity: userEntity));
    final response = await _getTeamsUsecase(NoParams());
    response.fold(
      (_) {
        emit(state.copyWith(userEntity: userEntity, teamsLoading: false));
      },
      (response) {
        if (response.success) {
          emit(
            state.copyWith(
              userEntity: userEntity,
              teams: response.teams,
              teamsLoading: false,
            ),
          );
        } else {
          emit(state.copyWith(userEntity: userEntity, teamsLoading: false));
        }
      },
    );
  }

  void changeMainTab(int index) {
    emit(state.copyWith(selectedMainTab: index));
  }

  void changeStatisticsTab(int index) {
    emit(state.copyWith(selectedStatisticsTab: index));
  }
}
