import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/LoginPageCubit/login_page_cubit.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginPageCubit>()..init(TextEditingController()),
      child: BlocBuilder<LoginPageCubit, LoginPageState>(
        builder: (context, state) {
          final cubit = context.read<LoginPageCubit>();
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () =>
                    GoRouter.of(context).goNamed(Routes.mainAppScreen),
                icon: Icon(CupertinoIcons.chevron_back),
              ),
            ),
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  disabled: state.controller!.text.length != 10,
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
                  onPress: () => cubit.loginController(context),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/login.svg",
                        height: 280,
                        width: 280,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Welcome to Cricklo!",
                        style: TextStyles.poppinsSemiBold.defaultBlack.copyWith(
                          fontSize: 32,
                          letterSpacing: -1.6,
                        ),
                      ),
                      Text(
                        "Login/Sign-up using your mobile number",
                        style: TextStyles.poppinsRegular.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputField(
                            controller: state.controller!,
                            hintText: "98651093842",
                            maxLength: 10,
                            textInputType: TextInputType.number,
                            showBuilder: false,
                            // scrollPadding: EdgeInsets.only(bottom: 200),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 8),
                            child: Text(
                              "Mobile login available only in India",
                              style: TextStyles.poppinsRegular.copyWith(
                                fontSize: 10,
                                letterSpacing: -0.2,
                                color: ColorsConstants.defaultBlack.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
