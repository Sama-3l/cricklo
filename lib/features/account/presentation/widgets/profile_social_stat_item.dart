import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class ProfileSocialStatItem extends StatelessWidget {
  const ProfileSocialStatItem({
    super.key,
    required this.stat,
    required this.title,
  });

  final double stat;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stat.round().toString(),
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
            color: ColorsConstants.defaultBlack,
          ),
        ),
        Text(
          title,
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 12,
            letterSpacing: -0.5,
            color: ColorsConstants.defaultBlack,
          ),
        ),
      ],
    );
  }
}
