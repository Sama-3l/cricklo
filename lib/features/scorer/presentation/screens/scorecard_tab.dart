import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/widgets/scorecard_partnership_item.dart';
import 'package:cricklo/features/scorer/presentation/widgets/scorecard_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  int selectedTeamIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScorerMatchCenterCubit>();
    final state = cubit.state;
    final battingTeam = state.matchCenterEntity!.innings.first.battingTeam;
    final bowlingTeam = state.matchCenterEntity!.teamA.id == battingTeam.id
        ? state.matchCenterEntity!.teamB
        : state.matchCenterEntity!.teamA;
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTeamIndex = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTeamIndex == 0
                              ? ColorsConstants.accentOrange
                              : ColorsConstants.accentOrange.withValues(
                                  alpha: 0.1,
                                ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          Methods.abbreviateTeamName(battingTeam.name),
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            color: selectedTeamIndex == 0
                                ? ColorsConstants.defaultWhite
                                : ColorsConstants.defaultBlack.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTeamIndex = 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTeamIndex == 1
                              ? ColorsConstants.accentOrange
                              : ColorsConstants.accentOrange.withValues(
                                  alpha: 0.1,
                                ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          Methods.abbreviateTeamName(bowlingTeam.name),
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            color: selectedTeamIndex == 1
                                ? ColorsConstants.defaultWhite
                                : ColorsConstants.defaultBlack.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            selectedTeamIndex == 0 &&
                        state.matchCenterEntity!.innings.isEmpty ||
                    battingTeam.battingOrder.isEmpty
                ? Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        Center(
                          child: Text(
                            "No Data To Show",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.accentOrange,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : selectedTeamIndex == 0 &&
                      state.matchCenterEntity!.innings.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildBattingStats(
                            selectedTeamIndex == 0 ? battingTeam : bowlingTeam,
                            state.matchCenterEntity!,
                          ),
                          const SizedBox(height: 20),
                          _buildBowlingStats(
                            selectedTeamIndex == 0 ? bowlingTeam : battingTeam,
                          ),
                          const SizedBox(height: 20),
                          _buildPartnerships(
                            selectedTeamIndex == 0 ? battingTeam : bowlingTeam,
                          ),
                        ],
                      ),
                    ),
                  )
                : selectedTeamIndex == 1 &&
                          state.matchCenterEntity!.innings.isEmpty ||
                      state.matchCenterEntity!.innings.length == 1
                ? Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        Center(
                          child: Text(
                            "No Data To Show",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.accentOrange,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBattingStats(
                            selectedTeamIndex == 0 ? battingTeam : bowlingTeam,
                            state.matchCenterEntity!,
                          ),
                          const SizedBox(height: 20),
                          _buildBowlingStats(
                            selectedTeamIndex == 0 ? bowlingTeam : battingTeam,
                          ),
                          const SizedBox(height: 20),
                          _buildPartnerships(
                            selectedTeamIndex == 0 ? battingTeam : bowlingTeam,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
      // : selectedTeamIndex == 1 &&
      //           state.matchCenterEntity!.innings.isEmpty ||
      //       state.matchCenterEntity!.innings.length == 1
      // ? Center(
      //     child: Text(
      //       "No Data To Show",
      //       style: TextStyles.poppinsSemiBold.copyWith(
      //         fontSize: 16,
      //         letterSpacing: -0.8,
      //         color: ColorsConstants.accentOrange,
      //       ),
      //     ),
      //   )
      // : Padding(
      //     padding: const EdgeInsets.only(top: 24.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           _buildBattingStats(
      //             selectedTeamIndex == 0 ? battingTeam : bowlingTeam,
      //             state.matchCenterEntity!,
      //           ),
      //           const SizedBox(height: 20),
      //           _buildBowlingStats(
      //             selectedTeamIndex == 0 ? bowlingTeam : battingTeam,
      //           ),
      //           const SizedBox(height: 20),
      //           _buildPartnerships(
      //             selectedTeamIndex == 0 ? battingTeam : bowlingTeam,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
    );
  }

  Widget _buildBattingStats(
    MatchTeamEntity battingTeam,
    MatchCenterEntity match,
  ) {
    final battingPlayers = battingTeam.battingOrder.values.toList();
    return battingPlayers.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(3.5), // Batsman name wider
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1.2),
                },

                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: ColorsConstants.accentOrange.withValues(
                        alpha: 0.15,
                      ),
                    ),
                    children: [
                      WidgetDecider.headerCell("Batsman"),
                      WidgetDecider.headerCell("R"),
                      WidgetDecider.headerCell("B"),
                      WidgetDecider.headerCell("4s"),
                      WidgetDecider.headerCell("6s"),
                      WidgetDecider.headerCell("SR"),
                    ],
                  ),
                  for (final player in battingPlayers)
                    TableRow(
                      children: [
                        ScorecardTabItem(
                          title: Methods.truncatePlayerName(player.name),
                          subTitle: Methods.getBatsmanSubtitle(player, match),
                        ),
                        ScorecardTabItem(title: "${player.stats.runs}"),
                        ScorecardTabItem(title: "${player.stats.balls}"),
                        ScorecardTabItem(title: "${player.stats.n4s}"),
                        ScorecardTabItem(title: "${player.stats.n6s}"),

                        ScorecardTabItem(
                          title: player.stats.sr.toStringAsFixed(1),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          );
  }

  Widget _buildBowlingStats(MatchTeamEntity bowlingTeam) {
    final bowlers = bowlingTeam.players
        .where((p) => Methods.oversToDecimal(p.stats.overs) > 0)
        .toList();

    if (bowlers.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: ColorsConstants.defaultBlack.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          columnWidths: const {
            0: FlexColumnWidth(3.5), // Batsman name wider
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1.2),
          },

          children: [
            TableRow(
              decoration: BoxDecoration(
                color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
              ),
              children: [
                WidgetDecider.headerCell("Bowler"),
                WidgetDecider.headerCell("O"),
                WidgetDecider.headerCell("R"),
                WidgetDecider.headerCell("W"),
                WidgetDecider.headerCell("M"),
                WidgetDecider.headerCell("Eco"),
              ],
            ),
            for (final bowler in bowlers)
              TableRow(
                children: [
                  ScorecardTabItem(
                    title: Methods.truncatePlayerName(bowler.name),
                  ),
                  ScorecardTabItem(title: bowler.stats.overs),
                  ScorecardTabItem(title: "${bowler.stats.runsGiven}"),
                  ScorecardTabItem(title: "${bowler.stats.wickets}"),
                  ScorecardTabItem(title: "${bowler.stats.maidens}"),

                  ScorecardTabItem(title: bowler.stats.eco.toStringAsFixed(1)),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildPartnerships(MatchTeamEntity battingTeam) {
    final partnerships = battingTeam.partnerships.reversed;
    if (partnerships.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Partnerships",
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 16,
              color: ColorsConstants.accentOrange,
              letterSpacing: -0.8,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...partnerships.map(
          (e) => ScorecardPartnershipItem(partnershipEntity: e),
        ),
      ],
    );
  }
}
