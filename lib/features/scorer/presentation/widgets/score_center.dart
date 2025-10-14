import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
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
          final currentCubit = context.read<ScoreCenterCubit>();
          final state = cubit.state;
          final currBatsmen = state.matchCenterEntity!.battingTeam!.currBatsmen;

          final strike = state.matchCenterEntity!.battingTeam!.onStrike;
          final inningsIndex = state.matchCenterEntity!.innings.length <= 2
              ? 0
              : 1;
          if (state.matchCenterEntity!.winner != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          currentCubit.newWicket(false);
                        },
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Match Completed",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          color: ColorsConstants.defaultWhite,
                          fontSize: 20,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Wrap(
                      spacing: 16, // horizontal spacing between children
                      runSpacing: 16, // vertical spacing between lines
                      alignment: WrapAlignment.center,
                      children: [
                        SecondaryButton(
                          title: "End Match",
                          onTap: () {
                            // cubit.showAbandonMatchDialog(context, () {});
                          },
                          color: ColorsConstants.defaultWhite,
                        ),
                        SecondaryButton(
                          title: "Undo",
                          onTap: () {
                            cubit.undoLastBall();
                          },
                          color: ColorsConstants.defaultWhite,
                        ),
                      ],
                    ),
                  ),
                ),

                Spacer(),
              ],
            );
          }
          if (state.matchCenterEntity!.battingTeam!.currBatsmen[0] == null ||
              state.matchCenterEntity!.battingTeam!.currBatsmen[1] == null) {
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
                        (state.matchCenterEntity!.battingTeam!.currBatsmen[0] ==
                                null ||
                            state
                                    .matchCenterEntity!
                                    .battingTeam!
                                    .currBatsmen[1] ==
                                null)
                        ? "Select Batsmen"
                        : "Select Batsman",
                    onTap: () {
                      WidgetDecider.showSelectBatsmenBottomSheet(
                        context,
                        players: state.matchCenterEntity!.battingTeam!.players,
                        currBatsmen:
                            state.matchCenterEntity!.battingTeam!.currBatsmen,
                        maxSelection:
                            currBatsmen[0] == null && currBatsmen[1] == null
                            ? 2
                            : 1,
                        onConfirm: (batsmen) => cubit.addBatsman(batsmen),
                        inningsIndex: inningsIndex,
                      );
                    },
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
                      bowler: true,
                      overEntity:
                          state
                              .matchCenterEntity!
                              .innings
                              .last
                              .oversData
                              .isEmpty
                          ? null
                          : state
                                .matchCenterEntity!
                                .innings
                                .last
                                .oversData
                                .last,
                      players: state.matchCenterEntity!.bowlingTeam!.players,
                      maxSelection: 1,
                      onConfirm: (bowler) => cubit.editBowler(bowler.first),
                      inningsIndex: inningsIndex,
                    ),
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
                Spacer(),
              ],
            );
          }
          if (currentCubit.state.extraType != null) {
            final extraType = currentCubit.state.extraType;
            late final String title;
            late final String short;
            switch (extraType) {
              case null:
                title = "";
                short = "";
                break;
              case ExtraType.penalty:
              case ExtraType.bonus:
              case ExtraType.moreRuns:
                title = "";
                short = "";
                break;
              case ExtraType.wide:
                title = "Wide";
                short = "Wd";
                break;
              case ExtraType.noBall:
                title = "No Ball";
                short = "NB";
                break;
              case ExtraType.bye:
                title = "Bye";
                short = "B";
                break;
              case ExtraType.legBye:
                title = "Leg Bye";
                short = "LB";
                break;
            }
            final extraRuns =
                extraType == ExtraType.bye || extraType == ExtraType.legBye
                ? [1, 2, 3, 4, 5, 6]
                : [0, 1, 2, 3, 4, 5, 6];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (Methods.validScorerOperation(
                            currBatsmen,
                            strike,
                          )) {
                            currentCubit.setExtraType(null);
                          } else {
                            WidgetDecider.showSnackBar(
                              context,
                              "Please select striker",
                            );
                          }
                        },
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        title,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          color: ColorsConstants.defaultWhite,
                          fontSize: 20,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Wrap(
                      spacing: 16, // horizontal spacing between children
                      runSpacing: 8, // vertical spacing between lines
                      alignment: WrapAlignment.center,
                      children: [
                        for (final label in extraRuns)
                          SecondaryButton(
                            title:
                                extraType == ExtraType.bye ||
                                    extraType == ExtraType.legBye
                                ? label == 0
                                      ? short
                                      : "$label $short"
                                : label == 0
                                ? short
                                : "$short + $label",
                            onTap: () async {
                              if (Methods.validScorerOperation(
                                currBatsmen,
                                strike,
                              )) {
                                int? sector;
                                if (extraType == ExtraType.noBall) {
                                  sector =
                                      await WidgetDecider.showWagonWheelBottomSheet(
                                        context,
                                        label,
                                      );
                                }
                                cubit.addBall(
                                  label,
                                  true,
                                  extraType: extraType,
                                  sector: sector,
                                  bowlerInvolved: state
                                      .matchCenterEntity!
                                      .bowlingTeam!
                                      .bowler,
                                  batsmanInvolved: state
                                      .matchCenterEntity!
                                      .battingTeam!
                                      .onStrike,
                                  secondBatsman: currBatsmen
                                      .where(
                                        (e) =>
                                            e!.playerId !=
                                            state
                                                .matchCenterEntity!
                                                .battingTeam!
                                                .onStrike!
                                                .playerId,
                                      )
                                      .first,
                                );
                                currentCubit.setExtraType(null);
                              } else {
                                WidgetDecider.showSnackBar(
                                  context,
                                  "Please select striker",
                                );
                              }
                            },
                            color: ColorsConstants.defaultWhite,
                          ),
                      ],
                    ),
                  ),
                ),

                Spacer(),
              ],
            );
          }
          if (currentCubit.state.wicket) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => currentCubit.newWicket(false),
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Wicket",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          color: ColorsConstants.defaultWhite,
                          fontSize: 20,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Wrap(
                      spacing: 16, // horizontal spacing between children
                      runSpacing: 16, // vertical spacing between lines
                      alignment: WrapAlignment.center,
                      children: [
                        for (final label in WicketType.values)
                          SecondaryButton(
                            title: label.title,
                            onTap: () async {
                              if (Methods.validScorerOperation(
                                currBatsmen,
                                strike,
                              )) {
                                if (label == WicketType.caught) {
                                  WidgetDecider.showSelectBatsmenBottomSheet(
                                    context,
                                    players: state
                                        .matchCenterEntity!
                                        .bowlingTeam!
                                        .players,
                                    maxSelection: 1,
                                    onConfirm: (player) {
                                      if (player.isNotEmpty) {
                                        cubit.addBall(
                                          0,
                                          false,
                                          bowlingTeamPlayerInvolved:
                                              player.last,
                                          wicketType: label,
                                          bowlerInvolved: state
                                              .matchCenterEntity!
                                              .bowlingTeam!
                                              .bowler,
                                          batsmanInvolved: state
                                              .matchCenterEntity!
                                              .battingTeam!
                                              .onStrike,
                                          secondBatsman: currBatsmen
                                              .where(
                                                (e) =>
                                                    e!.playerId !=
                                                    state
                                                        .matchCenterEntity!
                                                        .battingTeam!
                                                        .onStrike!
                                                        .playerId,
                                              )
                                              .first,
                                        );
                                        currentCubit.newWicket(false);
                                      }
                                    },
                                    inningsIndex: inningsIndex,
                                  );
                                } else if (label == WicketType.stumped) {
                                  WidgetDecider.showSelectBatsmenBottomSheet(
                                    context,
                                    players: state
                                        .matchCenterEntity!
                                        .bowlingTeam!
                                        .players,
                                    maxSelection: 1,
                                    onConfirm: (player) {
                                      if (player.isNotEmpty) {
                                        cubit.addBall(
                                          0,
                                          false,
                                          bowlingTeamPlayerInvolved:
                                              player.last,
                                          wicketType: label,
                                          bowlerInvolved: state
                                              .matchCenterEntity!
                                              .bowlingTeam!
                                              .bowler,
                                          batsmanInvolved: state
                                              .matchCenterEntity!
                                              .battingTeam!
                                              .onStrike,
                                          secondBatsman: currBatsmen
                                              .where(
                                                (e) =>
                                                    e!.playerId !=
                                                    state
                                                        .matchCenterEntity!
                                                        .battingTeam!
                                                        .onStrike!
                                                        .playerId,
                                              )
                                              .first,
                                        );
                                        currentCubit.newWicket(false);
                                      }
                                    },
                                    inningsIndex: inningsIndex,
                                  );
                                } else if (label == WicketType.runOut) {
                                  WidgetDecider.showOnRunOut(
                                    context,
                                    state
                                        .matchCenterEntity!
                                        .battingTeam!
                                        .currBatsmen,
                                    state
                                        .matchCenterEntity!
                                        .bowlingTeam!
                                        .players,
                                    (batsman, fielder, runs) {
                                      cubit.addBall(
                                        runs,
                                        false,
                                        batsmanInvolved: batsman,
                                        bowlingTeamPlayerInvolved: fielder,
                                        wicketType: label,
                                        bowlerInvolved: state
                                            .matchCenterEntity!
                                            .bowlingTeam!
                                            .bowler,
                                        secondBatsman: currBatsmen
                                            .where(
                                              (e) =>
                                                  e!.playerId !=
                                                  batsman.playerId,
                                            )
                                            .first,
                                      );
                                      currentCubit.newWicket(false);
                                    },
                                    inningsIndex,
                                  );
                                } else {
                                  cubit.addBall(
                                    0,
                                    false,
                                    wicketType: label,
                                    bowlerInvolved: state
                                        .matchCenterEntity!
                                        .bowlingTeam!
                                        .bowler,
                                    batsmanInvolved: state
                                        .matchCenterEntity!
                                        .battingTeam!
                                        .onStrike,
                                    secondBatsman: currBatsmen
                                        .where(
                                          (e) =>
                                              e!.playerId !=
                                              state
                                                  .matchCenterEntity!
                                                  .battingTeam!
                                                  .onStrike!
                                                  .playerId,
                                        )
                                        .first,
                                  );
                                  currentCubit.newWicket(false);
                                }
                              } else {
                                WidgetDecider.showSnackBar(
                                  context,
                                  "Please select striker",
                                );
                              }
                            },
                            color: ColorsConstants.defaultWhite,
                          ),
                      ],
                    ),
                  ),
                ),

                Spacer(),
              ],
            );
          }
          if (currentCubit.state.optionType != null) {
            final optionType = currentCubit.state.optionType;
            if (optionType == OptionType.more) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            currentCubit.newWicket(false);
                          },
                          child: Icon(
                            Icons.close,
                            size: 24,
                            color: ColorsConstants.defaultWhite,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "More",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultWhite,
                            fontSize: 20,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Wrap(
                        spacing: 16, // horizontal spacing between children
                        runSpacing: 16, // vertical spacing between lines
                        alignment: WrapAlignment.center,
                        children: [
                          SecondaryButton(
                            title: "Abandon",
                            onTap: () {
                              cubit.showAbandonMatchDialog(context, () {});
                            },
                            color: ColorsConstants.defaultWhite,
                          ),
                          SecondaryButton(
                            title: "End Innings",
                            onTap: () {
                              cubit.endInnings();
                              currentCubit.optionType(null);
                            },
                            color: ColorsConstants.defaultWhite,
                          ),
                          // SecondaryButton(
                          //   title: "Change Target",
                          //   onTap: () {
                          //     // cubit.addBall(0, false, wicketType: label);
                          //     // currentCubit.newWicket(false);
                          //   },
                          //   color: ColorsConstants.defaultWhite,
                          // ),
                          SecondaryButton(
                            title: "Retired Hurt",
                            onTap: () {
                              if (Methods.validScorerOperation(
                                currBatsmen,
                                strike,
                              )) {
                                cubit.addBall(
                                  0,
                                  false,
                                  wicketType: WicketType.retired,
                                  batsmanInvolved: state
                                      .matchCenterEntity!
                                      .battingTeam!
                                      .onStrike,
                                  secondBatsman: currBatsmen
                                      .where(
                                        (e) =>
                                            e!.playerId !=
                                            state
                                                .matchCenterEntity!
                                                .battingTeam!
                                                .onStrike!
                                                .playerId,
                                      )
                                      .first,
                                );
                                currentCubit.optionType(null);
                              } else {
                                WidgetDecider.showSnackBar(
                                  context,
                                  "Please select striker",
                                );
                              }
                            },
                            color: ColorsConstants.defaultWhite,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Spacer(),
                ],
              );
            } else if (optionType == OptionType.bonusRuns) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => currentCubit.newWicket(false),
                          child: Icon(
                            Icons.close,
                            size: 24,
                            color: ColorsConstants.defaultWhite,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Bonus Runs",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultWhite,
                            fontSize: 20,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Wrap(
                        spacing: 16, // horizontal spacing between children
                        runSpacing: 16, // vertical spacing between lines
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i in [1, 2, 3, 4, 5, 6, 8])
                            SecondaryButton(
                              title: "+$i",
                              onTap: () {
                                // cubit.addBall(0, false, wicketType: label);
                                // currentCubit.newWicket(false)
                                if (Methods.validScorerOperation(
                                  currBatsmen,
                                  strike,
                                )) {
                                  cubit.addBall(
                                    i,
                                    true,
                                    extraType: ExtraType.bonus,
                                  );
                                  currentCubit.optionType(null);
                                } else {
                                  WidgetDecider.showSnackBar(
                                    context,
                                    "Please select striker",
                                  );
                                }
                              },
                              color: ColorsConstants.defaultWhite,
                            ),
                        ],
                      ),
                    ),
                  ),

                  Spacer(),
                ],
              );
            } else if (optionType == OptionType.moreRuns) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => currentCubit.newWicket(false),
                          child: Icon(
                            Icons.close,
                            size: 24,
                            color: ColorsConstants.defaultWhite,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "More Runs",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultWhite,
                            fontSize: 20,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Wrap(
                        spacing: 16, // horizontal spacing between children
                        runSpacing: 16, // vertical spacing between lines
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i in [4, 5, 6, 7, 8, 9, 10])
                            SecondaryButton(
                              title: "$i",
                              onTap: () {
                                // cubit.addBall(0, false, wicketType: label);
                                // currentCubit.newWicket(false);
                                if (Methods.validScorerOperation(
                                  currBatsmen,
                                  strike,
                                )) {
                                  cubit.addBall(
                                    i,
                                    true,
                                    extraType: ExtraType.moreRuns,
                                    batsmanInvolved: state
                                        .matchCenterEntity!
                                        .battingTeam!
                                        .onStrike,
                                    secondBatsman: currBatsmen
                                        .where(
                                          (e) =>
                                              e!.playerId !=
                                              state
                                                  .matchCenterEntity!
                                                  .battingTeam!
                                                  .onStrike!
                                                  .playerId,
                                        )
                                        .first,
                                  );
                                  currentCubit.optionType(null);
                                } else {
                                  WidgetDecider.showSnackBar(
                                    context,
                                    "Please select striker",
                                  );
                                }
                              },
                              color: ColorsConstants.defaultWhite,
                            ),
                        ],
                      ),
                    ),
                  ),

                  Spacer(),
                ],
              );
            }
          }
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
                        // color: ColorsConstants.accentOrange.withValues(
                        //   alpha: 0.15,
                        // ),
                      ),
                      children: [
                        for (final label in ["1", "2", "3", "4", "6"])
                          SizedBox(
                            height: rowHeight,
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  if (Methods.validScorerOperation(
                                    currBatsmen,
                                    strike,
                                  )) {
                                    final sector =
                                        await WidgetDecider.showWagonWheelBottomSheet(
                                          context,
                                          int.parse(label),
                                        );
                                    cubit.addBall(
                                      int.parse(label),
                                      false,
                                      sector: sector,
                                      bowlerInvolved: state
                                          .matchCenterEntity!
                                          .bowlingTeam!
                                          .bowler,
                                      batsmanInvolved: state
                                          .matchCenterEntity!
                                          .battingTeam!
                                          .onStrike,
                                      secondBatsman: currBatsmen
                                          .where(
                                            (e) =>
                                                e!.playerId !=
                                                state
                                                    .matchCenterEntity!
                                                    .battingTeam!
                                                    .onStrike!
                                                    .playerId,
                                          )
                                          .first,
                                    );
                                  } else {
                                    WidgetDecider.showSnackBar(
                                      context,
                                      "Please select striker",
                                    );
                                  }
                                },
                                child: WidgetDecider.cell(label),
                              ),
                            ),
                          ),
                      ],
                    ),

                    TableRow(
                      decoration: BoxDecoration(
                        // color: ColorsConstants.accentOrange.withValues(
                        //   alpha: 0.15,
                        // ),
                      ),
                      children: [
                        for (final label in ["LB", "Bye", "Wide", "NB"])
                          SizedBox(
                            height: rowHeight,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (Methods.validScorerOperation(
                                    currBatsmen,
                                    strike,
                                  )) {
                                    ExtraType? extraType;
                                    switch (label) {
                                      case "LB":
                                        extraType = ExtraType.legBye;
                                        break;
                                      case "Bye":
                                        extraType = ExtraType.bye;
                                        break;
                                      case "Wide":
                                        extraType = ExtraType.wide;
                                        break;
                                      case "NB":
                                        extraType = ExtraType.noBall;
                                        break;
                                    }
                                    currentCubit.setExtraType(extraType);
                                  } else {}
                                },
                                child: WidgetDecider.cell(label),
                              ),
                            ),
                          ),
                        InkWell(
                          onTap: () => cubit.addBall(
                            0,
                            false,
                            bowlerInvolved:
                                state.matchCenterEntity!.bowlingTeam!.bowler,
                            batsmanInvolved:
                                state.matchCenterEntity!.battingTeam!.onStrike,
                            secondBatsman: currBatsmen
                                .where(
                                  (e) =>
                                      e!.playerId !=
                                      state
                                          .matchCenterEntity!
                                          .battingTeam!
                                          .onStrike!
                                          .playerId,
                                )
                                .first,
                          ),
                          child: SizedBox(
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
                        ),
                      ],
                    ),

                    TableRow(
                      decoration: BoxDecoration(
                        // color: ColorsConstants.accentOrange.withValues(
                        //   alpha: 0.15,
                        // ),
                      ),
                      children: [
                        InkWell(
                          onTap: () => currentCubit.optionType(OptionType.more),
                          child: SizedBox(
                            height: rowHeight,
                            child: Center(child: WidgetDecider.cell("More")),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              currentCubit.optionType(OptionType.bonusRuns),
                          child: SizedBox(
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
                        ),
                        InkWell(
                          onTap: () =>
                              currentCubit.optionType(OptionType.moreRuns),
                          child: SizedBox(
                            height: rowHeight,
                            child: Center(child: WidgetDecider.cell("4 5 6 7")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (state
                                    .matchCenterEntity!
                                    .innings
                                    .last
                                    .oversData
                                    .isEmpty ||
                                (state
                                            .matchCenterEntity!
                                            .innings
                                            .last
                                            .oversData
                                            .length ==
                                        1 &&
                                    state
                                        .matchCenterEntity!
                                        .innings
                                        .last
                                        .oversData
                                        .last
                                        .balls
                                        .isEmpty)) {
                              WidgetDecider.showSnackBar(
                                context,
                                "Can't Undo Now",
                              );
                            } else {
                              cubit.undoLastBall();
                            }
                          },
                          child: SizedBox(
                            height: rowHeight,
                            child: Center(child: WidgetDecider.cell("Undo")),
                          ),
                        ),
                        InkWell(
                          onTap: () => currentCubit.newWicket(true),
                          child: SizedBox(
                            height: rowHeight,
                            child: Center(child: WidgetDecider.cell("Out")),
                          ),
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
