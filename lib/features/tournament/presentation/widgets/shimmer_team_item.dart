import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:cricklo/core/utils/constants/theme.dart';

class ShimmerOverviewItem extends StatelessWidget {
  const ShimmerOverviewItem({
    super.key,
    this.logo,
    required this.title,
    this.subtitle,
    this.topTitle,
  });

  final String? logo;
  final String title;
  final String? subtitle;
  final String? topTitle;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          // Top title placeholder
          if (topTitle != null) ...[
            Container(
              width: 60,
              height: 12,
              decoration: BoxDecoration(
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),
          ],

          // Circle avatar shimmer
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsConstants.defaultBlack.withValues(alpha: 0.2),
            ),
          ),

          const SizedBox(height: 8),

          // Title shimmer
          Container(
            width: 90,
            height: 12,
            decoration: BoxDecoration(
              color: ColorsConstants.defaultBlack.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // Subtitle shimmer
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Container(
              width: 50,
              height: 10,
              decoration: BoxDecoration(
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
