import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_header_information.dart';
import 'package:cricklo/features/account/presentation/widgets/recent_form_stats.dart';
import 'package:cricklo/features/account/presentation/widgets/yearly_review.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerOverview extends StatefulWidget {
  const PlayerOverview({
    super.key,
    required this.userEntity,
    this.onFollow,
    required this.follow,
  });

  final UserEntity userEntity;
  final Function()? onFollow;
  final bool follow;

  @override
  State<PlayerOverview> createState() => _PlayerOverviewState();
}

class _PlayerOverviewState extends State<PlayerOverview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24),
      child: ListView(
        children: [
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeaderInformation(user: widget.userEntity),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (widget.userEntity.profileId !=
                          GlobalVariables.user!.profileId) ...[
                        Expanded(
                          child: PrimaryButton(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            disabled: false,
                            onPress: () => widget.onFollow == null
                                ? {}
                                : widget.onFollow!(),
                            noShadow: true,
                            radius: 16,
                            color: widget.follow
                                ? ColorsConstants.defaultBlack
                                : ColorsConstants.accentOrange,
                            child: widget.follow
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Followed",
                                        style: TextStyles.poppinsSemiBold
                                            .copyWith(
                                              fontSize: 10,
                                              letterSpacing: -0.5,
                                              color:
                                                  ColorsConstants.defaultWhite,
                                            ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: ColorsConstants.defaultWhite,
                                        size: 12,
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Follow",
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 10,
                                      letterSpacing: -0.5,
                                      color: ColorsConstants.defaultWhite,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: PrimaryButton(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          color: ColorsConstants.urlBlue,
                          disabled: false,
                          onPress: () {},
                          noShadow: true,
                          radius: 16,
                          child: Text(
                            "Share Profile",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.5,
                              color: ColorsConstants.defaultWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),
              SectionHeader(title: "Recent Form", showIcon: false),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  height: 48 * 2 + 16,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          RecentFormStats(
                            title: "Bat",
                            stats: ["-", "-", "-", "-", "-"],
                          ),
                          const SizedBox(height: 16),
                          RecentFormStats(
                            title: "Bowl",
                            stats: ["-", "-", "-", "-", "-"],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SectionHeader(title: "Yearly Review", showIcon: false),
              YearlyReview(),
              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}
