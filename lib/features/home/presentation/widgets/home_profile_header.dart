import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/profile_header_stats_table.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeProfileHeader extends StatelessWidget {
  const HomeProfileHeader({super.key, required this.userEntity});

  final UserEntity? userEntity;

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<MainAppCubit>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SectionHeader(title: "Following"),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(16),
            // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
            color: ColorsConstants.defaultWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: ColorsConstants.surfaceOrange,
                    child: Icon(
                      CupertinoIcons.person_fill,
                      size: 16,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userEntity!.name,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Methods.getPlayerType(userEntity!),
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 10,
                          letterSpacing: -0.2,
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (userEntity!.playerType == PlayerType.batter ||
                  userEntity!.playerType == PlayerType.allRounder) ...[
                Text(
                  "Batting Stats",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 12,
                    letterSpacing: -0.5,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
                const SizedBox(height: 8),
                ProfileHeaderStatsTable(
                  heading: ["Matches", "Runs", "Average"],
                  stats: [0, 0, 0],
                ),
              ],

              if (userEntity!.playerType == PlayerType.allRounder)
                const SizedBox(height: 16),

              if (userEntity!.playerType == PlayerType.bowler ||
                  userEntity!.playerType == PlayerType.allRounder) ...[
                Text(
                  "Bowling Stats",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 12,
                    letterSpacing: -0.5,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
                const SizedBox(height: 8),
                ProfileHeaderStatsTable(
                  heading: ["Matches", "Wickets", "Economy"],
                  stats: [0, 0, 0],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
