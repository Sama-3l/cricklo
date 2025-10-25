import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:cricklo/core/utils/constants/theme.dart';

class ShimmerSocialStatItem extends StatelessWidget {
  const ShimmerSocialStatItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 16,
            decoration: BoxDecoration(
              color: ColorsConstants.textBlack.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              letterSpacing: -0.5,
              color: ColorsConstants.defaultBlack,
            ),
          ),
        ],
      ),
    );
  }
}
