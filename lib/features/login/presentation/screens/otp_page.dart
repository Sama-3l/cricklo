import 'dart:async';

import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/OtpPageCubit/otp_page_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int secondsRemaining = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = secondsRemaining == 0;
    final part1 = widget.phoneNumber.substring(0, 3);
    final part2 = widget.phoneNumber.substring(3, 6);
    final part3 = widget.phoneNumber.substring(6, 10);
    return BlocBuilder<OtpPageCubit, OtpPageState>(
      builder: (context, state) {
        final cubit = context.read<OtpPageCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorsConstants.defaultWhite,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: Icon(CupertinoIcons.back, size: 24),
            ),
            title: Text(
              "Enter OTP",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultBlack,
              ),
            ),
            actions: [],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                disabled: state.otp.length != 6,
                child: state.loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: ColorsConstants.defaultWhite,
                        ),
                      )
                    : Text(
                        "Login",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                onPress: () => cubit.verifyOtp(widget.phoneNumber, context),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/otp.svg",
                    height: 280,
                    width: 280,
                  ),
                  Text(
                    "Enter OTP",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultBlack,
                      fontSize: 32,
                      letterSpacing: -1.6,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Enter otp sent to your mobile number:",
                        style: TextStyles.poppinsRegular.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      Text(
                        "+91-$part1-$part2-$part3",
                        style: TextStyles.poppinsBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  OtpTextField(
                    numberOfFields: 6,
                    fieldWidth: 44,
                    borderColor: ColorsConstants.accentOrange,
                    focusedBorderColor: ColorsConstants.accentOrange,
                    cursorColor: ColorsConstants.accentOrange,
                    showFieldAsBox: true,
                    textStyle: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 14,
                      color: ColorsConstants.defaultBlack,
                      letterSpacing: -0.8,
                    ),
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) =>
                        cubit.updateOtp(verificationCode),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Text(
                            isActive ? "Re-send OTP" : "Re-send OTP",
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 12,
                              letterSpacing: -0.5,
                              color: !isActive
                                  ? ColorsConstants.onSurfaceGrey
                                  : ColorsConstants.urlBlue,
                            ),
                          ),
                          Positioned.fill(
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 1,
                                color: !isActive
                                    ? ColorsConstants.onSurfaceGrey
                                    : ColorsConstants.urlBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        isActive ? "" : " : ",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.onSurfaceGrey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isActive ? "" : "00:$secondsRemaining",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: !isActive
                              ? ColorsConstants.onSurfaceGrey
                              : ColorsConstants.urlBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
