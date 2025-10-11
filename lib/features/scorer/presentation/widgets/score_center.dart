import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/cubit/scorer_center_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreKeepingCenter extends StatefulWidget {
  const ScoreKeepingCenter({super.key});

  @override
  State<ScoreKeepingCenter> createState() => _ScoreKeepingCenterState();
}

class _ScoreKeepingCenterState extends State<ScoreKeepingCenter> {
  bool showPercentages = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreCenterCubit(),
      child: BlocBuilder<ScoreCenterCubit, ScoreCenterState>(
        builder: (context, state) {
          final cubit = context.read<ScorerMatchCenterCubit>();
          final state = cubit.state;
          final currBatsmen = state.matchCenterEntity!.battingTeam!.currBatsmen;
          if (currBatsmen == null ||
              currBatsmen.isEmpty ||
              currBatsmen.length < 2) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Text(
                    "Select Batsman",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultWhite,
                      fontSize: 20,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: SecondaryButton(
                    title:
                        state.matchCenterEntity!.battingTeam!.currBatsmen ==
                                null ||
                            (state
                                    .matchCenterEntity!
                                    .battingTeam!
                                    .currBatsmen!
                                    .isNotEmpty &&
                                state
                                        .matchCenterEntity!
                                        .battingTeam!
                                        .currBatsmen!
                                        .length <
                                    2)
                        ? "Select Batsmen"
                        : "Select Batsman",
                    onTap: () => WidgetDecider.showSelectBatsmenBottomSheet(
                      context,
                      players: state.matchCenterEntity!.battingTeam!.players,
                      maxSelection:
                          currBatsmen != null && currBatsmen.isNotEmpty
                          ? 2 - currBatsmen.length
                          : 2,
                      onConfirm: (batsmen) => cubit.addBatsman(batsmen),
                    ),
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
                Spacer(),
              ],
            );
          }
          if (state.matchCenterEntity!.bowlingTeam!.bowler == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Text(
                    "Select Bowler",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultWhite,
                      fontSize: 20,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: SecondaryButton(
                    title: "Select Bowler",
                    onTap: () => WidgetDecider.showSelectBatsmenBottomSheet(
                      context,
                      players: state.matchCenterEntity!.bowlingTeam!.players,
                      maxSelection: 1,
                      onConfirm: (bowler) => cubit.editBowler(bowler.first),
                    ),
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
                Spacer(),
              ],
            );
          }
          // return Table(
          //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //   columnWidths: const {
          //     0: FlexColumnWidth(), // Batsman name wider
          //     1: FlexColumnWidth(),
          //     2: FlexColumnWidth(),
          //     3: FlexColumnWidth(),
          //     4: FlexColumnWidth(),
          //     5: FlexColumnWidth(),
          //   },
          //   border: TableBorder(
          //     horizontalInside: BorderSide(color: ColorsConstants.defaultWhite),
          //     verticalInside: BorderSide(color: ColorsConstants.defaultWhite),
          //   ),
          //   children: [
          //     // 🟠 Header Row
          //     TableRow(
          //       decoration: BoxDecoration(
          //         color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
          //       ),
          //       children: [
          //         WidgetDecider.cell(
          //           "1",
          //           onTap: () {
          //             WidgetDecider.showWagonWheelBottomSheet(context, 1);
          //           },
          //         ),
          //         WidgetDecider.cell(
          //           "2",
          //           onTap: () {
          //             WidgetDecider.showWagonWheelBottomSheet(context, 2);
          //           },
          //         ),
          //         WidgetDecider.cell(
          //           "3",
          //           onTap: () {
          //             WidgetDecider.showWagonWheelBottomSheet(context, 3);
          //           },
          //         ),
          //         WidgetDecider.cell(
          //           "4",
          //           onTap: () {
          //             WidgetDecider.showWagonWheelBottomSheet(context, 4);
          //           },
          //         ),
          //         WidgetDecider.cell(
          //           "6",
          //           onTap: () {
          //             WidgetDecider.showWagonWheelBottomSheet(context, 6);
          //           },
          //         ),
          //       ],
          //     ),
          //     TableRow(
          //       decoration: BoxDecoration(
          //         color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
          //       ),
          //       children: [
          //         WidgetDecider.cell("LB"),
          //         WidgetDecider.cell("Bye"),
          //         WidgetDecider.cell("Wide"),
          //         WidgetDecider.cell("NB"),
          //         Align(
          //           alignment: Alignment.center,
          //           child: Container(
          //             height: 8,
          //             width: 8,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(8),
          //               color: ColorsConstants.defaultWhite,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     TableRow(
          //       decoration: BoxDecoration(
          //         color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
          //       ),
          //       children: [
          //         WidgetDecider.cell("More"),
          //         Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Icon(
          //               Icons.sports_baseball,
          //               color: ColorsConstants.defaultWhite,
          //             ),
          //           ),
          //         ),
          //         WidgetDecider.cell("4 5 6 7"),
          //         WidgetDecider.cell("Undo"),
          //         WidgetDecider.cell("Out"),
          //       ],
          //     ),
          //   ],
          // );

          return Container(
            width: double.infinity,
            height: double.infinity,
            color: ColorsConstants.accentOrange,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final int rowCount = 3; // number of TableRow entries you have
                final double rowHeight = constraints.maxHeight / rowCount;

                return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                  },
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: ColorsConstants.defaultWhite,
                    ),
                    verticalInside: BorderSide(
                      color: ColorsConstants.defaultWhite,
                    ),
                  ),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: ColorsConstants.accentOrange.withValues(
                          alpha: 0.15,
                        ),
                      ),
                      children: [
                        for (final label in ["1", "2", "3", "4", "6"])
                          SizedBox(
                            height: rowHeight,
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final sector =
                                      await WidgetDecider.showWagonWheelBottomSheet(
                                        context,
                                        int.parse(label),
                                      );
                                  cubit.addBall(
                                    int.parse(label),
                                    false,
                                    sector: sector,
                                  );
                                },
                                child: WidgetDecider.cell(label),
                              ),
                            ),
                          ),
                      ],
                    ),

                    TableRow(
                      decoration: BoxDecoration(
                        color: ColorsConstants.accentOrange.withValues(
                          alpha: 0.15,
                        ),
                      ),
                      children: [
                        for (final label in ["LB", "Bye", "Wide", "NB"])
                          SizedBox(
                            height: rowHeight,
                            child: Center(child: WidgetDecider.cell(label)),
                          ),
                        SizedBox(
                          height: rowHeight,
                          child: Center(
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorsConstants.defaultWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    TableRow(
                      decoration: BoxDecoration(
                        color: ColorsConstants.accentOrange.withValues(
                          alpha: 0.15,
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: rowHeight,
                          child: Center(child: WidgetDecider.cell("More")),
                        ),
                        SizedBox(
                          height: rowHeight,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.sports_baseball,
                                color: ColorsConstants.defaultWhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: rowHeight,
                          child: Center(child: WidgetDecider.cell("4 5 6 7")),
                        ),
                        SizedBox(
                          height: rowHeight,
                          child: Center(child: WidgetDecider.cell("Undo")),
                        ),
                        SizedBox(
                          height: rowHeight,
                          child: Center(child: WidgetDecider.cell("Out")),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
