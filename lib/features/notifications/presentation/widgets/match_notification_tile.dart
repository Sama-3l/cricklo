import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class MatchNotificationTile extends StatelessWidget {
  const MatchNotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
      ),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Top row: Team images + VS + LIVE
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dummy Match",
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 12,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                Text(
                  "1st October, 2025",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 10,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Team 1
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/team_1.png"),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Mumbai Riders",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  "VS",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/team_2.png"),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Gujrat Langoors",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Ambedkar Park, Ambedkar Park, Lucknow, Uttar Pradesh",
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 10,
                letterSpacing: -0.2,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    disabled: false,
                    onPress: () {},
                    noShadow: true,
                    child: Text(
                      "Accept",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultWhite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    disabled: false,
                    onPress: () {},
                    color: ColorsConstants.accentOrange.withValues(alpha: 0.2),
                    noShadow: true,
                    child: Text(
                      "Deny",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
