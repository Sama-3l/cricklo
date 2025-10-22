import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class OverviewItem extends StatelessWidget {
  const OverviewItem({
    super.key,
    required this.title,
    this.subtitle,
    this.topTitle,
  });

  final String title;
  final String? subtitle;
  final String? topTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (topTitle != null) ...[
          Text(
            topTitle!,
            style: TextStyles.poppinsLight.copyWith(
              fontSize: 12,
              color: ColorsConstants.defaultBlack,
            ),
          ),
          const SizedBox(height: 4),
        ],
        CircleAvatar(
          radius: 40,
          backgroundColor: ColorsConstants.surfaceOrange,
          child: Icon(
            Icons.people,
            size: 24,
            color: ColorsConstants.defaultBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 16,
            color: ColorsConstants.defaultBlack,
            letterSpacing: -0.8,
          ),
        ),
        if (subtitle != null) ...[
          Text(
            subtitle!.toUpperCase(),
            style: TextStyles.poppinsLight.copyWith(
              fontSize: 12,
              color: ColorsConstants.defaultBlack,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ],
    );
  }
}
