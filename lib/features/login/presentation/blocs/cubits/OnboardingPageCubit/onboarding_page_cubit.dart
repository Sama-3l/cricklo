import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/data/entities/onboarding_usecase_entity.dart';
import 'package:cricklo/features/login/data/usecases/onboarding_usecase.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'onboarding_page_state.dart';

class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  final OnboardingUseCase _onboardingUseCase;

  OnboardingPageCubit(this._onboardingUseCase) : super(OnboardingPageLoading());

  onboardingComplete(
    BuildContext context,
    UserEntity userEntity,
    List<bool> ballingOptions,
    List<bool> battingOptions,
  ) async {
    userEntity = userEntity.copyWith(
      bowlerType:
          userEntity.playerType == PlayerType.bowler ||
              userEntity.playerType == PlayerType.allRounder
          ? BowlerType.values[ballingOptions.indexWhere((e) => e)]
          : null,
      batterType:
          userEntity.playerType == PlayerType.batter ||
              userEntity.playerType == PlayerType.allRounder
          ? BatterType.values[battingOptions.indexWhere((e) => e)]
          : null,
    );
    String playerType = "";
    String? batterType;
    String? bowlerType;

    switch (userEntity.playerType) {
      case PlayerType.allRounder:
        playerType = 'AllRounder';
        break;
      case PlayerType.batter:
        playerType = 'Batsman';
        break;
      case PlayerType.bowler:
        playerType = 'Bowler';
        break;
    }

    switch (userEntity.batterType) {
      case BatterType.leftHand:
        batterType = 'LEFT_HANDED';
        break;
      case BatterType.rightHand:
        batterType = 'RIGHT_HANDED';
        break;
      default:
        batterType = null;
        break;
    }

    switch (userEntity.bowlerType) {
      case BowlerType.leftArmSpin:
        bowlerType = 'LEFT_ARM_LEGSPIN';
        break;
      case BowlerType.leftArmPace:
        bowlerType = 'LEFT_ARM_FAST';
        break;
      case BowlerType.rightArmSpin:
        bowlerType = 'RIGHT_ARM_LEGSPIN';
        break;
      case BowlerType.rightArmPace:
        bowlerType = 'RIGHT_ARM_FAST';
        break;
      default:
        bowlerType = null;
    }
    emit(OnboardingPageLoading(loading: true));
    final profilePic = userEntity.profilePicFile != null
        ? await Methods.imageToBase64(userEntity.profilePicFile!)
        : null;
    final response = await _onboardingUseCase(
      OnboardingUsecaseEntity(
        profilePhoto: profilePic,
        name: userEntity.name,
        email: userEntity.email,
        playerType: playerType,
        batsmanType: batterType ?? "",
        bowlerType: bowlerType ?? "",
        area: userEntity.location.area,
        city: userEntity.location.city,
        state: userEntity.location.state,
        phoneNumber: userEntity.phoneNumber,
      ),
    );
    emit(OnboardingPageLoading(loading: false));
    response.fold(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // behavior: SnackBarBehavior.floating,
            backgroundColor: ColorsConstants.defaultBlack,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            content: Text(
              "Something went wrong. Try again",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
        );
      },
      (response) {
        GoRouter.of(context).goNamed(Routes.mainAppScreen, extra: response);
      },
    );
  }
}
