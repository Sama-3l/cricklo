import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/data/usecases/get_profile_usecase.dart';
import 'package:cricklo/features/account/data/usecases/get_teams_usecase.dart';
import 'package:cricklo/features/follow/data/entities/follow_usecase_entity.dart';
import 'package:cricklo/features/follow/data/usecases/follow_usecase.dart';
import 'package:cricklo/features/follow/data/usecases/unfollow_usecase.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final GetTeamsUsecase _getTeamsUsecase;
  final GetProfileUsecase _getProfileUsecase;
  final FollowUsecase _followUsecase;
  final UnFollowUsecase _unFollowUsecase;
  ProfilePageCubit(
    this._getTeamsUsecase,
    this._getProfileUsecase,
    this._followUsecase,
    this._unFollowUsecase,
  ) : super(const ProfilePageUpdate(teams: []));

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

  void followButton(BuildContext context) async {
    if (state.follow) {
      state.userEntity!.followers--;
    } else {
      state.userEntity!.followers++;
    }
    emit(state.copyWith(follow: !state.follow));
    if (state.follow) {
      final response = await _followUsecase(
        FollowUsecaseEntity(
          entityType: EntityType.player,
          entityId: state.userEntity!.profileId,
        ),
      );
      response.fold(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsConstants.defaultBlack,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              content: Text(
                "Something went wrong",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          );
          state.userEntity!.followers--;
          emit(state.copyWith(follow: !state.follow));
        },
        (response) {
          if (!response.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // behavior: SnackBarBehavior.floating,
                backgroundColor: ColorsConstants.defaultBlack,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                content: Text(
                  "Something went wrong",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
              ),
            );
            state.userEntity!.followers--;
            emit(state.copyWith(follow: !state.follow));
          }
        },
      );
    } else {
      final response = await _unFollowUsecase(
        FollowUsecaseEntity(
          entityType: EntityType.team,
          entityId: state.userEntity!.profileId,
        ),
      );
      response.fold((_) {}, (response) {
        if (!response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsConstants.defaultBlack,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              content: Text(
                "Something went wrong",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          );
          state.userEntity!.followers++;
          emit(state.copyWith(follow: !state.follow));
        }
      });
    }
  }

  void changeMainTab(int index) {
    emit(state.copyWith(selectedMainTab: index));
  }

  void changeStatisticsTab(int index) {
    emit(state.copyWith(selectedStatisticsTab: index));
  }
}
