import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/data/entities/verify_otp_usecase_entity.dart';
import 'package:cricklo/features/login/data/usecases/verify_otp_usecase.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'otp_page_state.dart';

class OtpPageCubit extends Cubit<OtpPageState> {
  final VerifyOtpUsecase _verifyOtpUsecase;

  OtpPageCubit(this._verifyOtpUsecase) : super(OtpPageUpdate(otp: ""));

  updateOtp(String value) => emit(OtpPageUpdate(otp: value));

  verifyOtp(String number, BuildContext context) async {
    emit(OtpPageLoading(otp: state.otp, loading: true));
    final response = await _verifyOtpUsecase(
      VerifyOtpUsecaseEntity(number: number, countryCode: "91", otp: state.otp),
    );
    emit(OtpPageLoading(otp: state.otp, loading: false));
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
          GoRouter.of(
            context,
          ).pushReplacementNamed(Routes.setPin, extra: [number, false]);
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
