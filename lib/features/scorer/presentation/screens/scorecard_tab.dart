import 'package:cricklo/core/utils/constants/enums.dart';
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
  int selectedInningsIndex = 0;

  @override
  Widget build(BuildContext context) {
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
    final match = state.matchCenterEntity!;
    final isTest = match.matchType == MatchType.test;

    final battingTeam = state.matchCenterEntity!.battingTeam!;
    final bowlingTeam = state.matchCenterEntity!.bowlingTeam!;

    final selectedTeam = selectedTeamIndex == 0 ? battingTeam : bowlingTeam;
    final inningsForTeam = match.innings
        .where((inn) => inn.battingTeam.id == selectedTeam.id)
        .toList();

    final currentInnings = inningsForTeam.isNotEmpty
        ? inningsForTeam[selectedInningsIndex.clamp(
            0,
            inningsForTeam.length - 1,
          )]
        : null;

    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟠 TEAM TABS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(bottom: 16),
              child: Row(
                children: [
                  for (int i = 0; i < 2; i++) ...[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          selectedTeamIndex = i;
                          selectedInningsIndex = 0;
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedTeamIndex == i
                                ? ColorsConstants.accentOrange
                                : ColorsConstants.accentOrange.withValues(
                                    alpha: 0.1,
                                  ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            Methods.abbreviateTeamName(
                              i == 0 ? battingTeam.name : bowlingTeam.name,
                            ),
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 16,
                              color: selectedTeamIndex == i
                                  ? ColorsConstants.defaultWhite
                                  : ColorsConstants.defaultBlack.withValues(
                                      alpha: 0.5,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (i == 0) const SizedBox(width: 8),
                  ],
                ],
              ),
            ),

            // 🧠 INNINGS SUB-TABS (Only for Test matches)
            if (isTest && inningsForTeam.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ).copyWith(bottom: 16),
                child: Row(
                  children: [
                    for (int i = 0; i < inningsForTeam.length; i++) ...[
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedInningsIndex = i),
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedInningsIndex == i
                                  ? ColorsConstants.accentOrange
                                  : ColorsConstants.accentOrange.withValues(
                                      alpha: 0.1,
                                    ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Innings ${inningsForTeam[i].number}",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 14,
                                color: selectedInningsIndex == i
                                    ? ColorsConstants.defaultWhite
                                    : ColorsConstants.defaultBlack.withValues(
                                        alpha: 0.5,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (i == 0) const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),

            // 🧾 MAIN CONTENT
            if (currentInnings == null)
              Expanded(
                child: Center(
                  child: Text(
                    "No Data To Show",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.accentOrange,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildBattingStats(
                        selectedTeam,
                        match,
                        selectedInningsIndex,
                      ),
                      const SizedBox(height: 20),
                      _buildBowlingStats(
                        selectedTeamIndex == 0 ? bowlingTeam : battingTeam,
                        match,
                        selectedInningsIndex,
                      ),
                      const SizedBox(height: 20),
                      _buildPartnerships(selectedTeam),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBattingStats(
    MatchTeamEntity battingTeam,
    MatchCenterEntity match,
    int selectedInningsIndex,
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
                        ScorecardTabItem(
                          title: "${player.stats[selectedInningsIndex].runs}",
                        ),
                        ScorecardTabItem(
                          title: "${player.stats[selectedInningsIndex].balls}",
                        ),
                        ScorecardTabItem(
                          title: "${player.stats[selectedInningsIndex].n4s}",
                        ),
                        ScorecardTabItem(
                          title: "${player.stats[selectedInningsIndex].n6s}",
                        ),

                        ScorecardTabItem(
                          title: player.stats[selectedInningsIndex].sr
                              .toStringAsFixed(1),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          );
  }

  Widget _buildBowlingStats(
    MatchTeamEntity bowlingTeam,
    MatchCenterEntity match,
    int selectedInningsIndex,
  ) {
    final bowlers = bowlingTeam.players
        .where(
          (p) =>
              Methods.oversToDecimal(p.stats[selectedInningsIndex].overs) > 0,
        )
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
                  ScorecardTabItem(
                    title: bowler.stats[selectedInningsIndex].overs,
                  ),
                  ScorecardTabItem(
                    title: "${bowler.stats[selectedInningsIndex].runsGiven}",
                  ),
                  ScorecardTabItem(
                    title: "${bowler.stats[selectedInningsIndex].wickets}",
                  ),
                  ScorecardTabItem(
                    title: "${bowler.stats[selectedInningsIndex].maidens}",
                  ),

                  ScorecardTabItem(
                    title: bowler.stats[selectedInningsIndex].eco
                        .toStringAsFixed(1),
                  ),
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
