import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/presentation/widgets/score_center.dart';
import 'package:cricklo/features/scorer/presentation/widgets/summary_stat_row.dart';
import 'package:flutter/material.dart';

class ScorerSummaryTab extends StatefulWidget {
  const ScorerSummaryTab({super.key});

  @override
  State<ScorerSummaryTab> createState() => _ScorerSummaryTabState();
}

class _ScorerSummaryTabState extends State<ScorerSummaryTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SUN",
                        style: TextStyles.poppinsBold.copyWith(
                          fontSize: 24,
                          color: ColorsConstants.defaultBlack,
                          letterSpacing: -1.2,
                        ),
                      ),
                      Text(
                        "1st innings",
                        style: TextStyles.poppinsRegular.copyWith(
                          fontSize: 16,
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.5,
                          ),
                          letterSpacing: -0.8,
                        ),
                      ),
                      Text(
                        "47 - 1",
                        style: TextStyles.poppinsBold.copyWith(
                          fontSize: 32,
                          color: ColorsConstants.accentOrange,
                          letterSpacing: -1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    // vertical: 16.0,
                    horizontal: 16,
                  ),
                  child: Container(
                    width: 0.5,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SummaryStatRow(
                          title: "Overs:",
                          stat: "0 / 20",
                          horizontalSpace: 20,
                        ),
                        const SizedBox(height: 12),
                        SummaryStatRow(
                          title: "Extras:",
                          stat: "0",
                          horizontalSpace: 18,
                        ),
                        const SizedBox(height: 12),
                        SummaryStatRow(
                          title: "CRR:",
                          stat: "0",
                          horizontalSpace: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Partnership:",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "0 (0)",
                style: TextStyles.poppinsBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
          ),
        ),
        WidgetDecider.buildBattingTable(batsmen: [], strikerName: ""),
        const SizedBox(height: 16),
        WidgetDecider.buildBowlingTable([]),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: ColorsConstants.accentOrange,
                child: Text(
                  "6",
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 12,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: ColorsConstants.defaultBlack.withValues(
                  alpha: 0.5,
                ),
                child: Text(
                  "2",
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 12,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: ColorsConstants.defaultBlack.withValues(
                  alpha: 0.5,
                ),
                child: Text(
                  "6 + Wd",
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 10,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: ColorsConstants.accentOrange),
            child: Center(child: ScoreKeepingCenter()),
          ),
        ),
      ],
    );
  }
}
