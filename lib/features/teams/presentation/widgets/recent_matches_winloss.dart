import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class RecentMatchesWinloss extends StatelessWidget {
  const RecentMatchesWinloss({
    super.key,
    required this.win,
    required this.loss,
  });

  final double win;
  final double loss;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${(win * 100).round()}%",
              style: TextStyles.poppinsBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultBlack,
              ),
            ),
            Text(
              "WON",
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: ColorsConstants.defaultBlack,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${(loss * 100).round()}%",
              style: TextStyles.poppinsBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultBlack,
              ),
            ),
            Text(
              "LOST",
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: ColorsConstants.defaultBlack,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
