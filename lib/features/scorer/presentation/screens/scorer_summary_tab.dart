import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/widgets/ball_data_row.dart';
import 'package:cricklo/features/scorer/presentation/widgets/score_center.dart';
import 'package:cricklo/features/scorer/presentation/widgets/summary_stat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScorerSummaryTab extends StatefulWidget {
  const ScorerSummaryTab({super.key});

  @override
  State<ScorerSummaryTab> createState() => _ScorerSummaryTabState();
}

class _ScorerSummaryTabState extends State<ScorerSummaryTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScorerMatchCenterCubit, ScorerMatchCenterState>(
      builder: (context, state) {
        final cubit = context.read<ScorerMatchCenterCubit>();
        final state = cubit.state;
        final currInnings = state.matchCenterEntity!.innings.last;
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
                            Methods.battingTeamAbbr(
                              currInnings.battingTeam.name,
                            ),
                            style: TextStyles.poppinsBold.copyWith(
                              fontSize: 24,
                              color: ColorsConstants.defaultBlack,
                              letterSpacing: -1.2,
                            ),
                          ),
                          Text(
                            "${currInnings.number}${Methods.numberSuffix(currInnings.number)} innings",
                            style: TextStyles.poppinsRegular.copyWith(
                              fontSize: 16,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.5,
                              ),
                              letterSpacing: -0.8,
                            ),
                          ),
                          Text(
                            "${currInnings.runs} - ${currInnings.wickets}",
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
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
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
                              stat:
                                  "${currInnings.overs} / ${state.matchCenterEntity!.overs}",
                              horizontalSpace: 20,
                            ),
                            const SizedBox(height: 12),
                            SummaryStatRow(
                              title: "Extras:",
                              stat: "${currInnings.extras}",
                              horizontalSpace: 18,
                            ),
                            const SizedBox(height: 12),
                            SummaryStatRow(
                              title: "CRR:",
                              stat: currInnings.crr.toStringAsFixed(2),
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
                    currInnings.partnerships.isEmpty
                        ? "0 (0)"
                        : "${currInnings.partnerships.last.runs} (${currInnings.partnerships.last.balls})",
                    style: TextStyles.poppinsBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
            ),

            WidgetDecider.buildBattingTable(
              players: state.matchCenterEntity!.battingTeam!.currBatsmen ?? [],
              onStrike: state.matchCenterEntity!.battingTeam!.onStrike,
              cubit: cubit,
            ),
            WidgetDecider.buildBowlingTable(
              state.matchCenterEntity!.bowlingTeam!.bowler,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 0.5,
                height: 0.5,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 8),
            state.matchCenterEntity!.innings.last.oversData.isEmpty
                ? Container(height: 24)
                : LastBallsRow(
                    overs: state.matchCenterEntity!.innings.last.oversData,
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
      },
    );
  }
}
