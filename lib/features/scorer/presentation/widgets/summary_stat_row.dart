import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class SummaryStatRow extends StatelessWidget {
  const SummaryStatRow({
    super.key,
    required this.title,
    required this.stat,
    required this.horizontalSpace,
  });

  final String title;
  final String stat;
  final double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 16,
            color: ColorsConstants.defaultBlack,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(width: horizontalSpace),
        Text(
          stat,
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
            color: ColorsConstants.defaultBlack,
          ),
        ),
      ],
    );
  }
}
