import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/SetPinCubit/set_pin_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class SetPinPage extends StatefulWidget {
  const SetPinPage({
    super.key,
    required this.phoneNumber,
    required this.loginPin,
  });

  final String phoneNumber;
  final bool loginPin;

  @override
  State<SetPinPage> createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPinCubit, SetPinState>(
      builder: (context, state) {
        final cubit = context.read<SetPinCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: Icon(CupertinoIcons.back, size: 24),
            ),
            title: Text(
              widget.loginPin ? "Login" : "Set Pin",
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
                disabled: state.pin.length != 4,
                child: state.loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: ColorsConstants.defaultWhite,
                        ),
                      )
                    : Text(
                        widget.loginPin ? "Enter Pin" : "Set Pin",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                onPress: () => widget.loginPin
                    ? cubit.login(widget.phoneNumber, context)
                    : cubit.setPin(widget.phoneNumber, context),
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
                    widget.loginPin ? "Enter Pin" : "Set Pin",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 32,
                      letterSpacing: -1.6,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  Text(
                    widget.loginPin
                        ? "Enter pin to access your account"
                        : "Set a pin-code for when you login again",
                    style: TextStyles.poppinsRegular.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(height: 32),
                  OtpTextField(
                    numberOfFields: 4,
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
                        cubit.updatePin(verificationCode),
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
