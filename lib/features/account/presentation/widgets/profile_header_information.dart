import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_social_stats.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class ProfileHeaderInformation extends StatelessWidget {
  const ProfileHeaderInformation({super.key, this.user, this.team});

  final UserEntity? user;
  final TeamEntity? team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: ColorsConstants.accentOrange.withValues(
                alpha: 0.2,
              ),
              backgroundImage: user != null
                  ? null
                  : team!.teamLogo.isNotEmpty
                  ? CachedNetworkImageProvider(team!.teamLogo)
                  : null,
              child: user != null
                  ? Icon(
                      CupertinoIcons.person_fill,
                      size: 16,
                      color: ColorsConstants.defaultBlack,
                    )
                  : team!.teamLogo.isEmpty
                  ? Icon(
                      CupertinoIcons.person_2_fill,
                      size: 16,
                      color: ColorsConstants.defaultBlack,
                    )
                  : null,
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user != null
                        ? user!.name
                        : team != null
                        ? team!.name
                        : "Guest",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ProfileSocialStats(stats: [0, 0, 0]),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user!.location.state.isNotEmpty ||
                      user!.location.city.isNotEmpty) ...[
                    Text(
                      user != null
                          ? "${user!.location.city}, ${user!.location.state}"
                          : team != null
                          ? "${team!.location.city}, ${team!.location.state}"
                          : "Guest",
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 14,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  InkWell(
                    onTap: () {
                      FlutterClipboard.copy(user!.profileId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: ColorsConstants.defaultWhite,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: ColorsConstants.accentOrange,
                              width: 1,
                            ),
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                          content: Center(
                            child: Text(
                              "Profile ID copied to Clipboard",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                color: ColorsConstants.accentOrange,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: ColorsConstants.accentOrange.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.copy,
                            size: 10,
                            color: ColorsConstants.defaultBlack,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user != null ? "Player ID: " : "Team ID: ",
                            style: TextStyles.poppinsRegular.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.2,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          Text(
                            user != null ? user!.profileId : team!.id,
                            maxLines: 2,
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.2,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (user != null)
                    Text(
                      Methods.getPlayerType(user!),
                      maxLines: 2,
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
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}
