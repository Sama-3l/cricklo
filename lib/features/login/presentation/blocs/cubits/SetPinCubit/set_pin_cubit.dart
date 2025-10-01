import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/data/entities/login_usecase_entity.dart';
import 'package:cricklo/features/login/data/entities/set_pin_usecase_entity.dart';
import 'package:cricklo/features/login/data/usecases/login_usecase.dart';
import 'package:cricklo/features/login/data/usecases/set_pin_usecase.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'set_pin_state.dart';

class SetPinCubit extends Cubit<SetPinState> {
  final SetPinUsecase _setPinUsecase;
  final LoginUsecase _loginUsecase;
  SetPinCubit(this._setPinUsecase, this._loginUsecase)
    : super(SetPinUpdate(pin: ""));

  updatePin(String pin) => emit(SetPinUpdate(pin: pin));

  setPin(String phoneNumber, BuildContext context) async {
    emit(SetPinLoading(pin: state.pin, loading: true));
    final response = await _setPinUsecase(
      SetPinUsecaseEntity(number: phoneNumber, pin: state.pin),
    );

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
        if (response.success) {
          GoRouter.of(context).pushReplacementNamed(
            Routes.completeProfileScreen,
            extra: phoneNumber,
          );
          emit(SetPinLoading(pin: state.pin, loading: false));
        } else {
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
        }
      },
    );
  }

  login(String phoneNumber, BuildContext context) async {
    emit(SetPinLoading(pin: state.pin, loading: true));
    final response = await _loginUsecase(
      LoginUsecaseEntity(phone: phoneNumber, password: state.pin),
    );
    emit(SetPinLoading(pin: state.pin, loading: false));
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
        if (response.success) {
          if (response.onboarded!) {
            GoRouter.of(context).goNamed(Routes.mainAppScreen);
          } else {
            GoRouter.of(context).pushReplacementNamed(
              Routes.completeProfileScreen,
              extra: phoneNumber,
            );
          }
        } else {
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
        }
      },
    );
  }
}
