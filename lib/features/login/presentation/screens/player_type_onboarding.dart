import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayerTypeOnboarding extends StatefulWidget {
  const PlayerTypeOnboarding({super.key, required this.user});

  final UserEntity user;

  @override
  State<PlayerTypeOnboarding> createState() => _PlayerTypeOnboardingState();
}

class _PlayerTypeOnboardingState extends State<PlayerTypeOnboarding> {
  final List<bool> optionValues = [false, false, false];

  @override
  Widget build(BuildContext context) {
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
                  radius: 32,
                  backgroundColor: ColorsConstants.accentOrange.withValues(
                    alpha: 0.2,
                  ),
                  child: Icon(
                    CupertinoIcons.person_fill,
                    size: 24,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Type of Player",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              const SizedBox(height: 16),
              WidgetDecider.optionBuilder(
                onTap: () => setState(() {
                  optionValues[0] = true;
                  optionValues[1] = false;
                  optionValues[2] = false;
                }),
                selected: optionValues[0],
                title: "Batter",
                selectedIcon: Icons.sports_cricket,
                unselectedIcon: Icons.sports_cricket_outlined,
              ),
              WidgetDecider.optionBuilder(
                onTap: () => setState(() {
                  optionValues[1] = true;
                  optionValues[0] = false;
                  optionValues[2] = false;
                }),
                selected: optionValues[1],
                title: "Bowler",
                selectedIcon: Icons.sports_baseball,
                unselectedIcon: Icons.sports_baseball_outlined,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              WidgetDecider.optionBuilder(
                onTap: () => setState(() {
                  optionValues[2] = true;
                  optionValues[1] = false;
                  optionValues[0] = false;
                }),
                selected: optionValues[2],
                title: "All-Rounder",
                selectedIcon: Icons.star,
                unselectedIcon: Icons.star_outline,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    disabled:
                        !(optionValues[0] ||
                            optionValues[1] ||
                            optionValues[2]),

                    child: Text(
                      "Next",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.6,
                        color: ColorsConstants.defaultWhite,
                      ),
                    ),
                    onPress: () => GoRouter.of(context).pushNamed(
                      Routes.onboardingScreenTwo,
                      extra: widget.user.copyWith(
                        playerType: PlayerType
                            .values[optionValues.indexWhere((e) => e)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
