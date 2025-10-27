import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/follow/data/entities/follow_usecase_entity.dart';
import 'package:cricklo/features/follow/data/usecases/get_followers_usecase.dart';
import 'package:cricklo/features/follow/domain/entities/follower_entity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'followers_page_state.dart';

class FollowerPageCubit extends Cubit<FollowersPageState> {
  final GetFollowersUsecase _getFollowersUsecase;

  FollowerPageCubit(this._getFollowersUsecase)
    : super(const FollowersPageUpdate(followers: [], loading: true));

  Future<void> init(
    BuildContext context,
    String entityId,
    EntityType entityType,
  ) async {
    emit(FollowersPageUpdate(followers: [], loading: true));

    final response = await _getFollowersUsecase(
      FollowUsecaseEntity(entityId: entityId, entityType: entityType),
    );

    response.fold(
      (failure) {
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
        emit(const FollowersPageUpdate(followers: [], loading: false));
      },
      (followersList) => emit(
        FollowersPageUpdate(followers: followersList.followers, loading: false),
      ),
    );
  }
}
