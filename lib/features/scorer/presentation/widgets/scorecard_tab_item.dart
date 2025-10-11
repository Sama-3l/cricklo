import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class ScorecardTabItem extends StatelessWidget {
  const ScorecardTabItem({super.key, required this.title, this.subTitle});

  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 12,
              color: ColorsConstants.defaultBlack,
              letterSpacing: -0.5,
            ),
          ),
          if (subTitle != null)
            Text(
              subTitle!,
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                letterSpacing: -0.2,
              ),
            ),
        ],
      ),
    );
  }
}
