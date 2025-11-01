import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/widgets/ball_data_row.dart';
import 'package:cricklo/features/scorer/presentation/widgets/score_center.dart';
import 'package:cricklo/features/scorer/presentation/widgets/summary_stat_row.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        if (state.loading) {
          return Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: ColorsConstants.accentOrange,
              ),
            ),
          );
        }
        if (state.matchCenterEntity == null) {
          return Center(
            child: Text(
              "No Data Yet",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 24,
                letterSpacing: -1.2,
                color: ColorsConstants.accentOrange,
              ),
            ),
          );
        }
        final currInnings = state.matchCenterEntity!.innings.last;
        if (state.matchCenterEntity!.abandoned) {
          return Center(
            child: Text(
              "Match Abandoned",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 24,
                letterSpacing: -1.2,
                color: ColorsConstants.accentOrange,
              ),
            ),
          );
        }
        final summary = Methods.getTargetOrLead(
          state.matchCenterEntity!.innings,
        );
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
                              state.matchCenterEntity!.battingTeam!.name,
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
                            Row(
                              children: [
                                SummaryStatRow(
                                  title: "Overs:",
                                  stat:
                                      "${currInnings.overs} ${state.matchCenterEntity!.matchType != MatchType.test ? "/ ${state.matchCenterEntity!.overs}" : ""}",
                                  horizontalSpace:
                                      state.matchCenterEntity!.innings.length >
                                          1
                                      ? 46
                                      : 20,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(24),
                                    onTap: () => GoRouter.of(context).push(
                                      Routes.followersPage,
                                      extra: [
                                        state.matchEntity!.matchID,
                                        EntityType.match,
                                      ],
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorsConstants.defaultBlack,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      // margin: EdgeInsets.only(top: 16, right: 16),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.people,
                                              size: 12,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              state.matchEntity!.followCount
                                                  .toString(),
                                              style: TextStyles.poppinsSemiBold
                                                  .copyWith(
                                                    color: ColorsConstants
                                                        .defaultBlack,
                                                    fontSize: 12,
                                                    letterSpacing: -0.8,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  state.matchCenterEntity!.innings.length > 1
                                  ? 4
                                  : 12,
                            ),
                            SummaryStatRow(
                              title: "Extras:",
                              stat: "${currInnings.extras}",
                              horizontalSpace:
                                  state.matchCenterEntity!.innings.length > 1
                                  ? 46
                                  : 18,
                            ),
                            SizedBox(
                              height:
                                  state.matchCenterEntity!.innings.length > 1
                                  ? 4
                                  : 12,
                            ),
                            SummaryStatRow(
                              title: "CRR:",
                              stat: currInnings.crr.toStringAsFixed(2),
                              horizontalSpace:
                                  state.matchCenterEntity!.innings.length > 1
                                  ? 60
                                  : 32,
                            ),

                            if (state.matchCenterEntity!.innings.length >
                                1) ...[
                              const SizedBox(height: 4),
                              state.matchCenterEntity!.matchType ==
                                      MatchType.test
                                  ? SummaryStatRow(
                                      title: summary["title"] ?? "",
                                      stat: summary["value"] ?? "",
                                      horizontalSpace: 43,
                                    )
                                  : SummaryStatRow(
                                      title: "Target:",
                                      stat: state
                                          .matchCenterEntity!
                                          .innings[state
                                                  .matchCenterEntity!
                                                  .innings
                                                  .length -
                                              2]
                                          .runs
                                          .toString(),

                                      horizontalSpace: 43,
                                    ),
                              if (state.matchCenterEntity!.matchType !=
                                  MatchType.test) ...[
                                const SizedBox(height: 4),
                                SummaryStatRow(
                                  title: "Req CRR",
                                  stat:
                                      (state
                                                  .matchCenterEntity!
                                                  .innings[state
                                                          .matchCenterEntity!
                                                          .innings
                                                          .length -
                                                      2]
                                                  .runs /
                                              (state.matchCenterEntity!.overs -
                                                  Methods.oversToDecimal(
                                                    currInnings.overs,
                                                  )))
                                          .toStringAsFixed(2),
                                  horizontalSpace: 32,
                                ),
                              ],
                            ],
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
                    state.matchCenterEntity!.battingTeam!.partnerships.isEmpty
                        ? "0 (0)"
                        : "${state.matchCenterEntity!.battingTeam!.partnerships.last.runs} (${state.matchCenterEntity!.battingTeam!.partnerships.last.balls})",
                    style: TextStyles.poppinsBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
            ),

            WidgetDecider.buildBattingTable(
              players: state.matchCenterEntity!.battingTeam!.currBatsmen,
              onStrike: state.matchCenterEntity!.battingTeam!.onStrike,
              cubit: cubit,
            ),
            WidgetDecider.buildBowlingTable(
              state.matchCenterEntity!.bowlingTeam!.bowler,
              state.matchCenterEntity!,
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
                ? Container(height: 32)
                : LastBallsRow(
                    overs: state.matchCenterEntity!.innings.last.oversData,
                  ),
            const SizedBox(height: 8),
            if (!state.spectator)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.accentOrange,
                  ),
                  child: Center(child: ScoreKeepingCenter()),
                ),
              ),
            if (state.spectator)
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ).copyWith(bottom: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        disabled: false,
                        color: state.matchEntity!.follows
                            ? ColorsConstants.defaultBlack
                            : ColorsConstants.urlBlue,
                        onPress: () => cubit.followButton(context),
                        child: state.matchEntity!.follows
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Followed",
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 10,
                                      letterSpacing: -0.5,
                                      color: ColorsConstants.defaultWhite,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: ColorsConstants.defaultWhite,
                                    size: 12,
                                  ),
                                ],
                              )
                            : Text(
                                "Follow Tournament",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 10,
                                  letterSpacing: -0.5,
                                  color: ColorsConstants.defaultWhite,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
