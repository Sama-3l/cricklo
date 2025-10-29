import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/partnership_stats_entity.dart';
import 'package:cricklo/features/teams/presentation/widgets/partnership_contri_graph_bar.dart';
import 'package:cricklo/features/teams/presentation/widgets/partnership_stat_player_stat.dart';
import 'package:flutter/material.dart';

class PartnershipStat extends StatelessWidget {
  final PartnershipStatsEntity partnership;

  const PartnershipStat({super.key, required this.partnership});

  @override
  Widget build(BuildContext context) {
    // Calculate contribution percentages
    final totalRuns = partnership.totalRuns == 0 ? 1 : partnership.totalRuns;
    final batsman1Percent = partnership.batsman1Runs / totalRuns;
    final batsman2Percent = partnership.batsman2Runs / totalRuns;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorsConstants.onSurfaceGrey,
      ),
      child: Row(
        children: [
          // 🧍 Left side: Player stats and contribution bars
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PartnershipStatPlayerStat(
                  score:
                      "${partnership.batsman1Runs} (${partnership.batsman1Balls})",
                  name: partnership.batsman1Name,
                ),
                const SizedBox(height: 12),
                PartnershipContriGraphBar(contriPercent: batsman1Percent),
                const SizedBox(height: 2),
                PartnershipContriGraphBar(contriPercent: batsman2Percent),
                const SizedBox(height: 12),
                PartnershipStatPlayerStat(
                  score:
                      "${partnership.batsman2Runs} (${partnership.batsman2Balls})",
                  name: partnership.batsman2Name,
                ),
              ],
            ),
          ),

          // 🏏 Right side: Total stats
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Text(
                    "${partnership.totalRuns}",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultBlack,
                      fontSize: 24,
                      letterSpacing: -1.6,
                    ),
                  ),
                  Text(
                    "${partnership.totalBalls} Balls",
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
