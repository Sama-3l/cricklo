import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatelessWidget {
  final String team1Name;
  final String team1Image;
  final String team2Name;
  final String team2Image;
  final String matchStatus; // e.g., "LIVE"
  final String stats; // e.g., "India 120/3 (15 overs)"

  const MatchTile({
    super.key,
    required this.team1Name,
    required this.team1Image,
    required this.team2Name,
    required this.team2Image,
    required this.matchStatus,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Top row: Team images + VS + LIVE
            if (matchStatus.toUpperCase() == "LIVE")
              Row(
                children: [
                  Text(
                    "Dummy Match",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "LIVE",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        color: ColorsConstants.defaultWhite,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Team 1
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage(team1Image),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          team1Name,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const Spacer(),
                        Text(
                          "146 (19.1)",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage(team2Image),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          team2Name,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "147/2 (18.5)",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
