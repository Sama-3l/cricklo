import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/data/entities/register_usecase_entity.dart';
import 'package:cricklo/features/login/data/usecases/register_usecase.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  final RegisterUsecase _registerUsecase;

  LoginPageCubit(this._registerUsecase) : super(LoginPageUpdateState());

  init(TextEditingController controller) {
    controller.addListener(() => updateController());
    emit(LoginPageUpdateState(controller: controller));
  }

  updateController() =>
      emit(LoginPageUpdateState(controller: state.controller));

  loginController(BuildContext context) async {
    emit(LoginPageLoading(controller: state.controller, loading: true));
    final response = await _registerUsecase(
      RegisterUsecaseEntity(number: state.controller!.text, countryCode: "91"),
    );
    emit(LoginPageLoading(controller: state.controller, loading: false));
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
      },

      (response) {
        if (response.status != null && response.status == 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsConstants.defaultBlack,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              content: Text(
                "Database Down. Try Again in 5 minutes",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          );
        } else if (response.success) {
          GoRouter.of(
            context,
          ).pushNamed(Routes.otpPage, extra: state.controller!.text);
        } else {
          if (response.errorCode == "USER_ALREADY_EXISTS") {
            GoRouter.of(
              context,
            ).pushNamed(Routes.setPin, extra: [state.controller!.text, true]);
          } else if (response.errorCode == "OTP_SEND_LOCK") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // behavior: SnackBarBehavior.floating,
                backgroundColor: ColorsConstants.defaultBlack,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                content: Text(
                  "Request for OTP after some time.",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
