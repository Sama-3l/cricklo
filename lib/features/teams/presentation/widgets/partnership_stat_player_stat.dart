import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class PartnershipStatPlayerStat extends StatelessWidget {
  const PartnershipStatPlayerStat({
    super.key,
    required this.score,
    required this.name,
  });

  final String score;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          score,
          style: TextStyles.poppinsMedium.copyWith(
            color: ColorsConstants.defaultBlack,
            fontSize: 12,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          name,
          style: TextStyles.poppinsMedium.copyWith(
            color: ColorsConstants.defaultBlack,
            fontSize: 12,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
