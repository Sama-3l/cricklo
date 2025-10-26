import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/follow/data/entities/follow_usecase_entity.dart';
import 'package:cricklo/features/follow/data/usecases/follow_usecase.dart';
import 'package:cricklo/features/follow/data/usecases/unfollow_usecase.dart';
import 'package:cricklo/features/teams/data/usecases/get_team_details_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'team_page_state.dart';

class TeamPageCubit extends Cubit<TeamPageState> {
  final GetTeamDetailsUsecase _getTeamDetailsUsecase;
  final FollowUsecase _followUsecase;
  final UnFollowUsecase _unFollowUsecase;
  TeamPageCubit(
    this._getTeamDetailsUsecase,
    this._followUsecase,
    this._unFollowUsecase,
  ) : super(
        TeamPageUpdate(
          selectedMainTab: 0,
          selectedPlayersTab: 0,
          selectedStatsTab: 0,
          selectedStatsTabTableType: 0,
          team: null,
          follow: false,
        ),
      );

  init(BuildContext context, TeamEntity team) async {
    emit(
      TeamPageUpdate(
        loading: true,
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: 0,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: state.selectedStatsTabTableType,
        team: team,
        follow: state.follow,
      ),
    );
    final response = await _getTeamDetailsUsecase(team.id);
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
        emit(
          TeamPageUpdate(
            loading: false,
            selectedMainTab: state.selectedMainTab,
            selectedPlayersTab: 0,
            selectedStatsTab: state.selectedStatsTab,
            selectedStatsTabTableType: state.selectedStatsTabTableType,
            team: team,
            follow: state.follow,
          ),
        );
      },
      (response) {
        if (response.success) {
          final team = response.team;
          if (team!.players
              .where((e) => e.teamRole != TeamRole.invited)
              .isEmpty) {
            emit(
              TeamPageUpdate(
                loading: false,
                selectedMainTab: state.selectedMainTab,
                selectedPlayersTab: 3,
                selectedStatsTab: state.selectedStatsTab,
                selectedStatsTabTableType: state.selectedStatsTabTableType,
                team: team,
                follow: state.team!.userFollows,
              ),
            );
          } else {
            emit(
              TeamPageUpdate(
                loading: false,
                selectedMainTab: state.selectedMainTab,
                selectedPlayersTab: 0,
                selectedStatsTab: state.selectedStatsTab,
                selectedStatsTabTableType: state.selectedStatsTabTableType,
                team: team,
                follow: state.team!.userFollows,
              ),
            );
          }
        }
      },
    );
  }

  void changeMainTab(int index) {
    emit(
      TeamPageUpdate(
        follow: state.follow,
        team: state.team,
        selectedMainTab: index,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: state.selectedStatsTabTableType,
      ),
    );
  }

  void changePlayersTab(int index) {
    emit(
      TeamPageUpdate(
        team: state.team,
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: index,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: state.selectedStatsTabTableType,
        follow: state.follow,
      ),
    );
  }

  void changeStatsTab(int index) {
    emit(
      TeamPageUpdate(
        team: state.team,
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: index,
        selectedStatsTabTableType: 0,
        follow: state.follow,
      ),
    );
  }

  void changeStatsTabTable(int index) {
    emit(
      TeamPageUpdate(
        team: state.team,
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: index,
        follow: state.follow,
      ),
    );
  }

  void followButton(BuildContext context) async {
    if (state.follow) {
      state.team!.followers--;
    } else {
      state.team!.followers++;
    }
    emit(
      TeamPageUpdate(
        team: state.team,
        selectedMainTab: state.selectedMainTab,
        selectedPlayersTab: state.selectedPlayersTab,
        selectedStatsTab: state.selectedStatsTab,
        selectedStatsTabTableType: state.selectedStatsTabTableType,
        follow: !state.follow,
      ),
    );
    if (state.follow) {
      final response = await _followUsecase(
        FollowUsecaseEntity(
          entityType: EntityType.team,
          entityId: state.team!.id,
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
          state.team!.followers--;
          emit(
            TeamPageUpdate(
              team: state.team,
              selectedMainTab: state.selectedMainTab,
              selectedPlayersTab: state.selectedPlayersTab,
              selectedStatsTab: state.selectedStatsTab,
              selectedStatsTabTableType: state.selectedStatsTabTableType,
              follow: !state.follow,
            ),
          );
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
            state.team!.followers--;
            emit(
              TeamPageUpdate(
                team: state.team,
                selectedMainTab: state.selectedMainTab,
                selectedPlayersTab: state.selectedPlayersTab,
                selectedStatsTab: state.selectedStatsTab,
                selectedStatsTabTableType: state.selectedStatsTabTableType,
                follow: !state.follow,
              ),
            );
          }
        },
      );
    } else {
      final response = await _unFollowUsecase(
        FollowUsecaseEntity(
          entityType: EntityType.team,
          entityId: state.team!.id,
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
          state.team!.followers++;
          emit(
            TeamPageUpdate(
              team: state.team,
              selectedMainTab: state.selectedMainTab,
              selectedPlayersTab: state.selectedPlayersTab,
              selectedStatsTab: state.selectedStatsTab,
              selectedStatsTabTableType: state.selectedStatsTabTableType,
              follow: !state.follow,
            ),
          );
        }
      });
    }
  }
}
