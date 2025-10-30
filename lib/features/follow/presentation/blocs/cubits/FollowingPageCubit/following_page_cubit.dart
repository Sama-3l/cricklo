import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/follow/data/usecases/get_following_usecase.dart';
import 'package:cricklo/features/follow/domain/entities/following_match_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_player_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_team_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'following_page_state.dart';

class FollowingPageCubit extends Cubit<FollowingPageState> {
  final GetFollowingUsecase _getFollowingUsecase;

  FollowingPageCubit(this._getFollowingUsecase)
    : super(
        const FollowingPageUpdate(
          players: [],
          teams: [],
          matches: [],
          tournaments: [],
          loading: true,
        ),
      );

  Future<void> init(BuildContext context, String profileId) async {
    emit(
      const FollowingPageUpdate(
        players: [],
        teams: [],
        matches: [],
        tournaments: [],
        loading: true,
      ),
    );

    final response = await _getFollowingUsecase(profileId);

    response.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorsConstants.defaultBlack,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
          const FollowingPageUpdate(
            players: [],
            teams: [],
            matches: [],
            tournaments: [],
            loading: false,
          ),
        );
      },
      (followingData) {
        emit(
          FollowingPageUpdate(
            players: followingData.players,
            teams: followingData.teams,
            matches: followingData.matches,
            tournaments: followingData.tournaments,
            loading: false,
          ),
        );
      },
    );
  }

  void updateState() {
    emit(state.copyWith(loading: state.loading));
  }
}
