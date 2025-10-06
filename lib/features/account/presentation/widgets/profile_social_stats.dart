import 'package:cricklo/features/account/presentation/widgets/profile_social_stat_item.dart';
import 'package:flutter/material.dart';

class ProfileSocialStats extends StatelessWidget {
  const ProfileSocialStats({super.key, required this.stats});

  final List<double> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProfileSocialStatItem(stat: stats[0], title: "Matches"),
        ProfileSocialStatItem(stat: stats[1], title: "Followers"),
        ProfileSocialStatItem(stat: stats[2], title: "Following"),
      ],
    );
  }
}
