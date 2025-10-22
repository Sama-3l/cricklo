import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/presentation/widgets/partnership_contri_graph_bar.dart';
import 'package:cricklo/features/teams/presentation/widgets/partnership_stat_player_stat.dart';
import 'package:flutter/material.dart';

class PartnershipStat extends StatelessWidget {
  const PartnershipStat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorsConstants.onSurfaceGrey,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PartnershipStatPlayerStat(score: "2 (9)", name: "Aaryan Khan"),
                const SizedBox(height: 12),
                PartnershipContriGraphBar(contriPercent: 1),
                const SizedBox(height: 2),
                PartnershipContriGraphBar(contriPercent: 0.2),
                const SizedBox(height: 12),
                PartnershipStatPlayerStat(score: "2 (9)", name: "Aaryan Khan"),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Text(
                    "40",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultBlack,
                      fontSize: 24,
                      letterSpacing: -1.6,
                    ),
                  ),
                  Text(
                    "31 Balls",
                    style: TextStyles.poppinsMedium.copyWith(
                      color: ColorsConstants.defaultBlack,
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
