import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_social_stat_item.dart';
import 'package:cricklo/features/account/presentation/widgets/shimmer_social_stat_item.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSocialStats extends StatelessWidget {
  const ProfileSocialStats({
    super.key,
    required this.stats,
    this.heading = const ["Matches", "Followers", "Following"],
    required this.entityType,
    required this.entityId,
    required this.loading,
  });

  final List<int> stats;
  final List<String> heading;
  final EntityType entityType;
  final String entityId;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerSocialStatItem(title: heading[0]),
              ShimmerSocialStatItem(title: heading[1]),
              ShimmerSocialStatItem(title: heading[2]),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileSocialStatItem(
                stat: stats[0],
                title: heading[0],
                onTap: () {},
              ),
              ProfileSocialStatItem(
                stat: stats[1],
                title: heading[1],
                onTap: () {
                  if (entityType == EntityType.player) {
                    GoRouter.of(
                      context,
                    ).push(Routes.followersPage, extra: [entityId, entityType]);
                  }
                },
              ),
              ProfileSocialStatItem(
                stat: stats[2],
                title: heading[2],
                onTap: () {
                  if (entityType == EntityType.team) {
                    GoRouter.of(
                      context,
                    ).push(Routes.followersPage, extra: [entityId, entityType]);
                  }
                },
              ),
            ],
          );
  }
}
