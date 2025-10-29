import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/domain/entities/matchwise_stats_entity.dart';
import 'package:flutter/material.dart';

class MatchStatsTile extends StatelessWidget {
  final MatchWiseStatsEntity match;

  const MatchStatsTile({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
        color: ColorsConstants.onSurfaceGrey,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.format,
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (match.tournamentName.isNotEmpty)
                    Text(
                      match.tournamentName,
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                        letterSpacing: -0.5,
                      ),
                    ),
                ],
              ),

              Text(
                Methods.formatDateTime(
                  DateTime(
                    match.date.year,
                    match.date.month,
                    match.date.day,
                    match.time.hour,
                    match.time.minute,
                  ),
                  addLineBreak: true,
                ),
                textAlign: TextAlign.end,
                style: TextStyles.poppinsSemiBold.copyWith(
                  color: ColorsConstants.defaultBlack,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          const Divider(thickness: 1),

          // ===== Team vs Opposition =====
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "${match.teamName} vs ${match.oppositionTeamName}",
              textAlign: TextAlign.center,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultBlack,
              ),
            ),
          ),

          const Divider(thickness: 1),
          const SizedBox(height: 8),

          // ===== Batting Stats =====
          if (match.runs != null || match.balls != null)
            _buildStatsSection(
              title: "Batting",
              stats: {
                'Order': match.battingPosition?.toString() ?? '-',
                'Runs': match.runs?.toString() ?? '0',
                'Balls': match.balls?.toString() ?? '0',
                '4s': match.fours?.toString() ?? '0',
                '6s': match.sixes?.toString() ?? '0',
                'SR': (match.strikeRate?.toStringAsFixed(1) ?? '0'),
              },
              context: context,
            ),

          const SizedBox(height: 12),

          // ===== Bowling Stats =====
          if (match.overs != null || match.wickets != null)
            _buildStatsSection(
              title: "Bowling",
              stats: {
                'Overs': match.overs?.toString() ?? '0',
                'Runs': match.bowlingRuns?.toString() ?? '0',
                'Wkts': match.wickets?.toString() ?? '0',
                'Mdn': match.maidens?.toString() ?? '0',
                'Eco': match.economy?.toStringAsFixed(1) ?? '0',
              },
              context: context,
            ),
        ],
      ),
    );
  }

  Widget _buildStatsSection({
    required String title,
    required Map<String, String> stats,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stats.entries.map((e) {
        return Column(
          children: [
            Text(
              e.key,
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              e.value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        );
      }).toList(),
    );
  }
}
