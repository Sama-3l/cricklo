import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/OnboardingPageCubit/onboarding_page_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PlayerTypeOnboardingTwo extends StatefulWidget {
  const PlayerTypeOnboardingTwo({super.key, required this.user});

  final UserEntity user;

  @override
  State<PlayerTypeOnboardingTwo> createState() =>
      _PlayerTypeOnboardingTwoState();
}

class _PlayerTypeOnboardingTwoState extends State<PlayerTypeOnboardingTwo> {
  final List<bool> battingOptions = [false, false];
  final List<bool> ballingOptions = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingPageCubit>();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: Icon(CupertinoIcons.back, size: 24),
            ),
            title: Text(
              "Complete Your Profile",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultBlack,
              ),
            ),
            actions: [],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: ColorsConstants.accentOrange.withValues(
                        alpha: 0.2,
                      ),
                      backgroundImage: widget.user.profilePicFile != null
                          ? FileImage(widget.user.profilePicFile!)
                          : null,
                      child: widget.user.profilePicFile == null
                          ? Icon(
                              CupertinoIcons.person_fill,
                              size: 24,
                              color: ColorsConstants.defaultBlack,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (widget.user.playerType == PlayerType.batter ||
                      widget.user.playerType == PlayerType.allRounder) ...[
                    Text(
                      "Type of Batter",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    WidgetDecider.optionBuilder(
                      showIcon: false,
                      onTap: () => setState(() {
                        battingOptions[0] = true;
                        battingOptions[1] = false;
                      }),
                      selected: battingOptions[0],
                      title: "Left-Hand Batter",
                      selectedIcon: Icons.sports_cricket,
                      unselectedIcon: Icons.sports_cricket_outlined,
                    ),
                    WidgetDecider.optionBuilder(
                      showIcon: false,
                      onTap: () => setState(() {
                        battingOptions[0] = false;
                        battingOptions[1] = true;
                      }),
                      selected: battingOptions[1],
                      title: "Right-Hand Batter",
                      selectedIcon: Icons.sports_cricket,
                      unselectedIcon: Icons.sports_cricket_outlined,
                      padding: EdgeInsets.only(top: 12, bottom: 24),
                    ),
                  ],

                  if (widget.user.playerType == PlayerType.bowler ||
                      widget.user.playerType == PlayerType.allRounder) ...[
                    Text(
                      "Type of Bowler",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    WidgetDecider.optionBuilder(
                      showIcon: false,
                      onTap: () => setState(() {
                        for (int i = 0; i < ballingOptions.length; i++) {
                          ballingOptions[i] = (i == 0);
                        }
                      }),
                      selected: ballingOptions[0],
                      title: "Left-Arm Spin Bowler",
                      selectedIcon: Icons.star_outline,
                      unselectedIcon: Icons.star_outline,
                    ),
                    WidgetDecider.optionBuilder(
                      showIcon: false,
                      padding: EdgeInsets.only(top: 12),
                      onTap: () => setState(() {
                        for (int i = 0; i < ballingOptions.length; i++) {
                          ballingOptions[i] = (i == 1);
                        }
                      }),
                      selected: ballingOptions[1],
                      title: "Left-Arm Pace Bowler",
                      selectedIcon: Icons.star,
                      unselectedIcon: Icons.star_outline,
                    ),
                    WidgetDecider.optionBuilder(
                      showIcon: false,
                      padding: EdgeInsets.only(top: 12),
                      onTap: () => setState(() {
                        for (int i = 0; i < ballingOptions.length; i++) {
                          ballingOptions[i] = (i == 2);
                        }
                      }),
                      selected: ballingOptions[2],
                      title: "Right-Arm Spin Bowler",
                      selectedIcon: Icons.star,
                      unselectedIcon: Icons.star_outline,
                    ),
                    WidgetDecider.optionBuilder(
                      showIcon: false,
                      padding: EdgeInsets.only(top: 12),
                      onTap: () => setState(() {
                        for (int i = 0; i < ballingOptions.length; i++) {
                          ballingOptions[i] = (i == 3);
                        }
                      }),
                      selected: ballingOptions[3],
                      title: "Right-Arm Pace Bowler",
                      selectedIcon: Icons.star,
                      unselectedIcon: Icons.star_outline,
                    ),
                  ],
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        disabled:
                            !(battingOptions[0] || battingOptions[1]) &&
                            !(ballingOptions[0] ||
                                ballingOptions[1] ||
                                ballingOptions[2] ||
                                ballingOptions[3]),

                        child: state.loading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: ColorsConstants.defaultWhite,
                                ),
                              )
                            : Text(
                                "Enter App",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.6,
                                  color: ColorsConstants.defaultWhite,
                                ),
                              ),
                        onPress: () => cubit.onboardingComplete(
                          context,
                          widget.user,
                          ballingOptions,
                          battingOptions,
                        ),
                      ),
                    ),
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
