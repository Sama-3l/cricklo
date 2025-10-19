import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/account/data/usecases/get_profile_usecase.dart';
import 'package:cricklo/features/account/data/usecases/get_teams_usecase.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:meta/meta.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final GetTeamsUsecase _getTeamsUsecase;
  final GetProfileUsecase _getProfileUsecase;
  ProfilePageCubit(this._getTeamsUsecase, this._getProfileUsecase)
    : super(const ProfilePageUpdate(teams: []));

  init(String userId) async {
    emit(state.copyWith(loading: true));
    final response = await _getProfileUsecase(userId);
    response.fold(
      (_) {
        emit(state.copyWith(loading: false));
      },
      (response) {
        if (response.success) {
          emit(state.copyWith(userEntity: response.userEntity, loading: false));
          getTeams();
        } else {
          emit(state.copyWith(loading: false));
        }
      },
    );
  }

  Future<void> getTeams() async {
    emit(state.copyWith(teamsLoading: true));
    final response = await _getTeamsUsecase(NoParams());
    response.fold(
      (_) {
        emit(state.copyWith(teamsLoading: false));
      },
      (response) {
        if (response.success) {
          emit(state.copyWith(teams: response.teams, teamsLoading: false));
        } else {
          emit(state.copyWith(teamsLoading: false));
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
