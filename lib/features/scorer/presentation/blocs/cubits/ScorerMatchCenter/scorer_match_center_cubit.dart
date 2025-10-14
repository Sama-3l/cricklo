import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/innings_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_stats_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/partnership_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_center_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:go_router/go_router.dart';

part 'scorer_match_center_state.dart';

class ScorerMatchCenterCubit extends Cubit<ScorerMatchCenterState> {
  ScorerMatchCenterCubit()
    : super(
        ScorerMatchCenterUpdate(
          currentIndex: 0,
          loadedTabs: {0},
          matchEntity: null,
        ),
      );

  init(MatchEntity matchEntity) {
    final matchCenterEntity = MatchCenterEntity(
      matchID: matchEntity.matchID,
      dateAndTime: matchEntity.dateAndTime,
      overs: matchEntity.overs,
      matchType: matchEntity.matchType,
      tossWinner: matchEntity.tossWinner,
      tossChoice: matchEntity.tossChoice,
      teamA: MatchTeamEntity(
        partnerships: [],
        id: matchEntity.teamA.id,
        name: matchEntity.teamA.name,
        teamLogo: matchEntity.teamA.teamLogo,
        teamBanner: matchEntity.teamA.teamBanner,
        currBatsmen: [null, null],
        players: matchEntity.teamA.players
            .map(
              (e) => MatchPlayerEntity(
                id: e.id ?? e.playerId,
                playerId: e.playerId,
                name: e.name,
                captain: e.captain,
                teamRole: e.teamRole,
                playerType: e.playerType,
                batterType: e.batterType,
                bowlerType: e.bowlerType,
                stats: [
                  MatchPlayerStatsEntity(
                    runs: 0,
                    balls: 0,
                    n4s: 0,
                    n6s: 0,
                    sr: 0,
                    overs: "0",
                    runsGiven: 0,
                    maidens: 0,
                    wickets: 0,
                    eco: 0,
                    out: false,
                    caught: 0,
                    stumping: 0,
                    runout: 0,
                  ),
                ],
              ),
            )
            .toList(),
        location: matchEntity.teamA.location,
        battingOrder: {},
      ),
      teamB: MatchTeamEntity(
        id: matchEntity.teamB.id,
        name: matchEntity.teamB.name,
        teamLogo: matchEntity.teamB.teamLogo,
        teamBanner: matchEntity.teamB.teamBanner,
        currBatsmen: [null, null],
        partnerships: [],
        players: matchEntity.teamB.players
            .map(
              (e) => MatchPlayerEntity(
                id: e.id ?? e.playerId,
                playerId: e.playerId,
                name: e.name,
                captain: e.captain,
                teamRole: e.teamRole,
                playerType: e.playerType,
                batterType: e.batterType,
                bowlerType: e.bowlerType,
                stats: [
                  MatchPlayerStatsEntity(
                    runs: 0,
                    balls: 0,
                    n4s: 0,
                    n6s: 0,
                    sr: 0,
                    overs: "0",
                    runsGiven: 0,
                    maidens: 0,
                    wickets: 0,
                    eco: 0,
                    out: false,
                    caught: 0,
                    stumping: 0,
                    runout: 0,
                  ),
                ],
              ),
            )
            .toList(),
        location: matchEntity.teamB.location,
        battingOrder: {},
      ),
      location: matchEntity.location,
      scorer: MatchScorerEntity(
        playerId: matchEntity.scorer["profileId"],
        name: matchEntity.scorer["name"],
        profilePic: "",
      ),
      innings: [],
    );
    matchCenterEntity.innings.add(
      InningsEntity(
        battingTeam: matchCenterEntity.battingTeam!,
        runs: 0,
        wickets: 0,
        overs: "0",
        number: 1,
        crr: 0,
        extras: 0,
        oversData: [],
      ),
    );
    emit(
      state.copyWith(
        matchCenterEntity: matchCenterEntity,
        matchEntity: matchEntity,
      ),
    );
  }

  addBatsman(List<MatchPlayerEntity> batsman) {
    final team = state.matchCenterEntity!.battingTeam!;
    final currentBatting = team.currBatsmen;

    int nextOrderIndex() {
      // Find the next available index in battingOrder
      if (team.battingOrder.isEmpty) return 1;
      return team.battingOrder.keys.reduce((a, b) => a > b ? a : b) + 1;
    }

    void addToBattingOrder(MatchPlayerEntity player) {
      // Only add if not already present
      if (!team.battingOrder.values.any((p) => p.playerId == player.playerId)) {
        final index = nextOrderIndex();
        team.battingOrder[index] = player;
      }
    }

    // Update current batsmen
    if (batsman.length == 2) {
      currentBatting[0] = batsman[0];
      currentBatting[1] = batsman[1];
      setOnStrike(batsman[0]);
      // Save batting order
      addToBattingOrder(batsman[0]);
      addToBattingOrder(batsman[1]);
      // Add partnership
      state.matchCenterEntity!.battingTeam!.partnerships.add(
        PartnershipEntity(
          player1: batsman[0],
          player2: batsman[1],
          runs: 0,
          balls: 0,
        ),
      );
    } else if (currentBatting[0] == null) {
      currentBatting[0] = batsman[0];
      setOnStrike(currentBatting[0]!);
      addToBattingOrder(batsman[0]);
      late final MatchPlayerEntity stillPlaying = currentBatting[1]!;
      state.matchCenterEntity!.battingTeam!.partnerships.add(
        PartnershipEntity(
          player1: stillPlaying,
          player2: batsman[0],
          runs: 0,
          balls: 0,
        ),
      );
    } else {
      currentBatting[1] = batsman[0];
      setOnStrike(currentBatting[1]!);
      addToBattingOrder(batsman[0]);
      late final MatchPlayerEntity stillPlaying = currentBatting[0]!;
      state.matchCenterEntity!.battingTeam!.partnerships.add(
        PartnershipEntity(
          player1: stillPlaying,
          player2: batsman[0],
          runs: 0,
          balls: 0,
        ),
      );
    }

    emit(state.copyWith());
  }

  editBowler(MatchPlayerEntity? bowler) {
    state.matchCenterEntity!.bowlingTeam!.bowler = bowler;
    emit(state.copyWith());
  }

  setOnStrike(MatchPlayerEntity player) {
    state.matchCenterEntity!.battingTeam!.onStrike = player;
    emit(state.copyWith());
  }

  addRunsToPartnership(int runs, bool ballCounted) {
    if (ballCounted) {
      state.matchCenterEntity!.battingTeam!.partnerships.last.balls++;
    }
    state.matchCenterEntity!.battingTeam!.partnerships.last.runs += runs;
    emit(state.copyWith());
  }

  addStatsToBatsman(int runs, bool ballCounted, ExtraType? extraType) {
    final onStrike = state.matchCenterEntity!.battingTeam!.onStrike;
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    onStrike!.stats[inningsIndex].runs += runs;
    onStrike.stats[inningsIndex].balls++;
    addRunsToPartnership(runs, ballCounted);
    if (runs == 4) {
      if ((extraType != null && (extraType == ExtraType.noBall))) {
        onStrike.stats[inningsIndex].n4s++;
      } else if (extraType == null) {
        onStrike.stats[inningsIndex].n4s++;
      }
    }
    if (runs == 6) {
      if ((extraType != null && (extraType == ExtraType.noBall))) {
        onStrike.stats[inningsIndex].n6s++;
      } else if (extraType == null) {
        onStrike.stats[inningsIndex].n6s++;
      }
    }
    onStrike.stats[inningsIndex].sr =
        (onStrike.stats[inningsIndex].runs /
            onStrike.stats[inningsIndex].balls) *
        100;
    if (runs.isOdd) {
      final batsmen = state.matchCenterEntity!.battingTeam!.currBatsmen;
      if (onStrike.playerId == batsmen[0]!.playerId) {
        setOnStrike(batsmen[1]!);
      } else {
        setOnStrike(batsmen[0]!);
      }
    }
  }

  addBowlerRuns(int runs, bool wicket, bool maiden, ExtraType? extraType) {
    final bowler = state.matchCenterEntity!.bowlingTeam!.bowler;
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    if (extraType != null) {
      if (extraType == ExtraType.legBye || extraType == ExtraType.bye) {
        bowler!.stats[inningsIndex].overs = Methods.incrementOver(
          bowler.stats[inningsIndex].overs,
        );
        bowler.stats[inningsIndex].runsGiven += runs;
      } else if (extraType != ExtraType.bonus &&
          extraType != ExtraType.penalty) {
        if (extraType == ExtraType.moreRuns) {
          bowler!.stats[inningsIndex].overs = Methods.incrementOver(
            bowler.stats[inningsIndex].overs,
          );
        }
        bowler!.stats[inningsIndex].runsGiven += runs;
      }
    } else {
      bowler!.stats[inningsIndex].overs = Methods.incrementOver(
        bowler.stats[inningsIndex].overs,
      );
      bowler.stats[inningsIndex].runsGiven += runs;
    }
    if (wicket) {
      bowler!.stats[inningsIndex].wickets++;
    }
    if (maiden) bowler!.stats[inningsIndex].maidens++;
    final oversDecimal = Methods.oversToDecimal(
      bowler!.stats[inningsIndex].overs,
    );
    bowler.stats[inningsIndex].eco = oversDecimal == 0
        ? 0
        : (bowler.stats[inningsIndex].runsGiven / oversDecimal);
  }

  bool addInningsRuns(BallEntity ball) {
    state.matchCenterEntity!.innings.last.runs += ball.totalRuns;
    if (!ball.isExtra ||
        (ball.extraType != null && ball.extraType == ExtraType.moreRuns)) {
      if (ball.wicketType != WicketType.retired) {
        state.matchCenterEntity!.innings.last.overs = Methods.incrementOver(
          state.matchCenterEntity!.innings.last.overs,
        );
      }
    }
    final oversDecimal = Methods.oversToDecimal(
      state.matchCenterEntity!.innings.last.overs,
    );
    state.matchCenterEntity!.innings.last.crr = oversDecimal == 0
        ? 0
        : state.matchCenterEntity!.innings.last.runs / oversDecimal;
    if (ball.isExtra) {
      if (ball.extraType != ExtraType.bonus &&
          ball.extraType != ExtraType.penalty &&
          ball.extraType != ExtraType.moreRuns) {
        state.matchCenterEntity!.innings.last.extras += ball.extraRuns;
      }
    }
    if (ball.wicketType != null) {
      state.matchCenterEntity!.innings.last.wickets++;
    }
    final match = state.matchCenterEntity!;
    final currentInnings = match.innings.last;

    // Common checks
    final bool oversCompleted = currentInnings.overs.length >= match.overs;
    final bool allOut =
        currentInnings.wickets >= currentInnings.battingTeam.players.length - 1;

    if (match.matchType != MatchType.test) {
      // 🏏 LIMITED OVERS MATCH
      if (oversCompleted || allOut) {
        print("endInnings (limited overs)");
        endInnings();
        return true;
      }
      return false;
    } else {
      // 🧠 TEST MATCH
      // 1️⃣ Innings ends if all out.
      if (allOut) {
        print("endInnings (test - all out)");
        endInnings();
        return true;
      }

      // 2️⃣ In 4th innings, if chasing team reaches or surpasses target.
      // if (match.innings.length == 4) {
      //   final target =
      //       match.innings[0].runs +
      //       match.innings[2].runs -
      //       match.innings[1].runs +
      //       1;
      //   if (currentInnings.runs >= target) {
      //     print("endInnings (test - target achieved)");
      //     endInnings();
      //     return true;
      //   }
      // }
      if (match.innings.length == 4) {
        if (allOut) {
          endInnings();
          return true;
        }
      }

      return false;
    }
  }

  void removeInningsRuns(BallEntity ball) {
    final innings = state.matchCenterEntity!.innings.last;

    // 1️⃣ Subtract total runs of the ball
    innings.runs -= ball.totalRuns;

    // 2️⃣ Revert overs if we incremented them
    if (!ball.isExtra ||
        (ball.extraType != null && ball.extraType == ExtraType.moreRuns)) {
      if (ball.wicketType != WicketType.retired) {
        innings.overs = Methods.decrementOver(innings.overs);
      }
    }

    // 3️⃣ Recalculate CRR
    final oversDecimal = Methods.oversToDecimal(innings.overs);
    innings.crr = oversDecimal == 0 ? 0 : innings.runs / oversDecimal;

    // 4️⃣ Subtract extras if needed
    if (ball.isExtra) {
      if (ball.extraType != ExtraType.bonus &&
          ball.extraType != ExtraType.penalty &&
          ball.extraType != ExtraType.moreRuns) {
        innings.extras -= ball.extraRuns;
        if (innings.extras < 0) innings.extras = 0; // safety check
      }
    }

    // 5️⃣ Subtract wicket if it was counted
    if (ball.wicketType != null) {
      innings.wickets--;
      if (innings.wickets < 0) innings.wickets = 0; // safety check
    }

    emit(state.copyWith());
  }

  void undoStatsForBatsman(
    int runs,
    ExtraType? extraType,
    MatchPlayerEntity batsman,
    bool ballCounted,
  ) {
    final battingTeam = state.matchCenterEntity!.battingTeam!;
    final onStrike = batsman;
    final currBatsmen = battingTeam.currBatsmen;

    // 1️⃣ If strike switched due to odd runs, switch back
    if (runs.isOdd && currBatsmen[0] != null && currBatsmen[1] != null) {
      if (state.matchCenterEntity!.battingTeam!.onStrike!.playerId ==
          currBatsmen[0]!.playerId) {
        setOnStrike(currBatsmen[1]!);
      } else {
        setOnStrike(currBatsmen[0]!);
      }
    }
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    // 2️⃣ Subtract runs and ball
    onStrike.stats[inningsIndex].runs -= runs;
    if (onStrike.stats[inningsIndex].balls > 0) {
      onStrike.stats[inningsIndex].balls--;
    }

    // 3️⃣ Subtract from partnership
    final lastPartnership =
        state.matchCenterEntity!.battingTeam!.partnerships.last;
    lastPartnership.runs -= runs;
    if (ballCounted && lastPartnership.balls > 0) {
      lastPartnership.balls--;
    }

    // 4️⃣ Revert 4s and 6s
    if (runs == 4 && (extraType == null || extraType == ExtraType.noBall)) {
      if (onStrike.stats[inningsIndex].n4s > 0) {
        onStrike.stats[inningsIndex].n4s--;
      }
    }
    if (runs == 6 && (extraType == null || extraType == ExtraType.noBall)) {
      if (onStrike.stats[inningsIndex].n6s > 0) {
        onStrike.stats[inningsIndex].n6s--;
      }
    }

    // 5️⃣ Recompute strike rate
    if (onStrike.stats[inningsIndex].balls > 0) {
      onStrike.stats[inningsIndex].sr =
          (onStrike.stats[inningsIndex].runs /
              onStrike.stats[inningsIndex].balls) *
          100;
    } else {
      onStrike.stats[inningsIndex].sr = 0;
    }
    emit(state.copyWith());
  }

  undoBowlerRuns(
    int runs,
    bool wicket,
    bool maiden,
    ExtraType? extraType,
    // BallEntity ball,
    MatchPlayerEntity bowler,
  ) {
    // Reverse over count
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    if (extraType != null) {
      if (extraType == ExtraType.legBye || extraType == ExtraType.bye) {
        bowler.stats[inningsIndex].overs = Methods.decrementOver(
          bowler.stats[inningsIndex].overs,
        );
        bowler.stats[inningsIndex].runsGiven -= runs;
      } else if (extraType != ExtraType.bonus &&
          extraType != ExtraType.penalty) {
        if (extraType == ExtraType.moreRuns) {
          bowler.stats[inningsIndex].overs = Methods.decrementOver(
            bowler.stats[inningsIndex].overs,
          );
        }
        bowler.stats[inningsIndex].runsGiven -= runs;
      }
    } else {
      bowler.stats[inningsIndex].overs = Methods.decrementOver(
        bowler.stats[inningsIndex].overs,
      );
      bowler.stats[inningsIndex].runsGiven -= runs;
    }

    // Reverse wicket if previously counted
    if (wicket && bowler.stats[inningsIndex].wickets > 0) {
      bowler.stats[inningsIndex].wickets--;
    }

    // Reverse maiden if previously counted
    if (maiden && bowler.stats[inningsIndex].maidens > 0) {
      bowler.stats[inningsIndex].maidens--;
    }

    // Recalculate economy
    final oversDecimal = Methods.oversToDecimal(
      bowler.stats[inningsIndex].overs,
    );
    bowler.stats[inningsIndex].eco = oversDecimal == 0
        ? 0
        : (bowler.stats[inningsIndex].runsGiven / oversDecimal);

    emit(state.copyWith());
  }

  undoWicketTakenBatsman(
    MatchPlayerEntity outBatsman,
    MatchPlayerEntity otherBatsman,
    bool lastDelivery, {
    WicketType? wicketType,
    MatchPlayerEntity? overBowler,
    MatchPlayerEntity? bowler,
    MatchPlayerEntity? overFielder,
    MatchPlayerEntity? fielderInvolved,
  }) {
    final currBatsmen = state.matchCenterEntity!.battingTeam!.currBatsmen;

    final getBackBatsman = state.matchCenterEntity!.battingTeam!.players
        .where((e) => e.playerId == outBatsman.playerId)
        .first;

    final repeatedPlayer = state.matchCenterEntity!.battingTeam!.players
        .where((e) => e.playerId == otherBatsman.playerId)
        .first;
    // print(repeatedPlayer!.name);
    // print(currBatsmen[0]!.name);
    // print(currBatsmen[1]!.name);
    // Re-add batsman to the slot where he was removed
    if (currBatsmen[0] != null &&
        currBatsmen[0]!.playerId == repeatedPlayer.playerId) {
      currBatsmen[1] = getBackBatsman;
    } else {
      currBatsmen[0] = getBackBatsman;
    }
    state.matchCenterEntity!.battingTeam!.partnerships.removeLast();
    // print(currBatsmen[0]!.name);
    // Reverse lastDelivery strike change and bowler edit
    if (lastDelivery) {
      if (getBackBatsman.playerId ==
          state.matchCenterEntity!.battingTeam!.currBatsmen[0]!.playerId) {
        setOnStrike(state.matchCenterEntity!.battingTeam!.currBatsmen[1]!);
      } else {
        setOnStrike(state.matchCenterEntity!.battingTeam!.currBatsmen[0]!);
      }
      // Revert editBowler(null)
      editBowler(bowler);
    }
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    // Revert batsman’s out status and wicket info
    for (var player in state.matchCenterEntity!.battingTeam!.players) {
      if (player.playerId == outBatsman.playerId) {
        player.stats[inningsIndex].out = false;
        player.stats[inningsIndex].wicketType = null;
        player.stats[inningsIndex].bowler = null;
        player.stats[inningsIndex].fielder = null;
        break;
      }
    }

    emit(state.copyWith());
  }

  wicketTakenBatsman(
    MatchPlayerEntity batsmen,
    bool lastDelivery, {
    WicketType? wicketType,
    MatchPlayerEntity? bowler,
    MatchPlayerEntity? fielderInvolved,
  }) {
    final currBatsmen = state.matchCenterEntity!.battingTeam!.currBatsmen;
    if (lastDelivery) {
      if (state.matchCenterEntity!.battingTeam!.currBatsmen[0]!.playerId ==
          state.matchCenterEntity!.battingTeam!.onStrike!.playerId) {
        setOnStrike(state.matchCenterEntity!.battingTeam!.currBatsmen[1]!);
      } else {
        setOnStrike(state.matchCenterEntity!.battingTeam!.currBatsmen[0]!);
      }
      editBowler(null);
    }
    if (batsmen.playerId == currBatsmen[0]!.playerId) {
      currBatsmen[0] = null;
    } else {
      currBatsmen[1] = null;
    }
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    for (var player in state.matchCenterEntity!.battingTeam!.players) {
      if (player.playerId == batsmen.playerId) {
        player.stats[inningsIndex].out = true;
        player.stats[inningsIndex].wicketType = wicketType;
        player.stats[inningsIndex].bowler = bowler!.name;
        if (fielderInvolved != null) {
          player.stats[inningsIndex].fielder = fielderInvolved.name;
        }
        break;
      }
    }
  }

  addBall(
    int runs,
    bool isExtra, {
    ExtraType? extraType,
    WicketType? wicketType,
    int? sector,
    MatchPlayerEntity? secondBatsman,
    MatchPlayerEntity? batsmanInvolved,
    MatchPlayerEntity? bowlerInvolved,
    MatchPlayerEntity? bowlingTeamPlayerInvolved,
  }) {
    final newBall = BallEntity(
      runs: runs,
      isExtra: isExtra,
      extraType: extraType,
      wicketType: wicketType,
      sector: sector,
      secondBatsman: secondBatsman,
      batsman: batsmanInvolved,
      bowler: bowlerInvolved,
      fielder: bowlingTeamPlayerInvolved?.copyWith(),
    );
    final bowler = state.matchCenterEntity!.bowlingTeam!.bowler;
    if (state.matchCenterEntity!.innings.last.oversData.isEmpty) {
      state.matchCenterEntity!.innings.last.oversData.add(
        OversEntity(
          runs: state.matchCenterEntity!.innings.last.runs,
          wickets: state.matchCenterEntity!.innings.last.wickets,
          overNumber: 1,
          bowler: bowler!,
          balls: [newBall],
          player1runs: 0,
          player1balls: 0,
          player2runs: 0,
          player2balls: 0,
          bowlerOvers: '',
          bowlerRuns: 0,
          bowlerMaidens: 0,
          bowlerWickets: 0,
          player1Id: '',
          player1Name: '',
          player2Id: '',
          player2Name: '',
          bowlerId: '',
          bowlerName: '',
        ),
      );
    } else {
      final lastOver = state.matchCenterEntity!.innings.last.oversData.last;
      if (lastOver.legalDeliveries == 6) {
        state.matchCenterEntity!.innings.last.oversData.add(
          OversEntity(
            runs: state.matchCenterEntity!.innings.last.runs,
            wickets: state.matchCenterEntity!.innings.last.wickets,
            overNumber: state.matchCenterEntity!.innings.length + 1,
            bowler: bowler!,
            balls: [newBall],
            player1runs: 0,
            player1balls: 0,
            player2runs: 0,
            player2balls: 0,
            bowlerOvers: '',
            bowlerRuns: 0,
            bowlerMaidens: 0,
            bowlerWickets: 0,
            player1Id: '',
            player1Name: '',
            player2Id: '',
            player2Name: '',
            bowlerId: '',
            bowlerName: '',
          ),
        );
      } else {
        state.matchCenterEntity!.innings.last.oversData.last.balls.add(newBall);
      }
    }

    if (!newBall.isExtra) {
      if (newBall.wicketType != null &&
          newBall.wicketType == WicketType.retired) {
        addStatsToBatsman(0, false, extraType);
      } else {
        addStatsToBatsman(runs, true, extraType);
      }
    } else if (newBall.extraType == ExtraType.noBall) {
      addStatsToBatsman(runs, false, extraType);
    } else if (newBall.extraType != ExtraType.bonus &&
        newBall.extraType != ExtraType.penalty) {
      if (newBall.extraType == ExtraType.moreRuns) {
        addStatsToBatsman(runs, true, extraType);
      } else {
        addStatsToBatsman(0, true, extraType);
      }
    }
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    bool maiden = false;
    if (state.matchCenterEntity!.innings.last.oversData.last.overRuns == 0 &&
        state.matchCenterEntity!.innings.last.oversData.last.legalDeliveries ==
            6) {
      maiden = true;
    }
    if (newBall.extraType != null &&
        (newBall.extraType == ExtraType.legBye ||
            newBall.extraType == ExtraType.bye)) {
      addBowlerRuns(
        0,
        newBall.wicketType != null &&
            (newBall.wicketType == WicketType.bowled ||
                newBall.wicketType == WicketType.caught ||
                newBall.wicketType == WicketType.stumped ||
                newBall.wicketType == WicketType.hitWicket ||
                newBall.wicketType == WicketType.lbw),
        maiden,
        extraType,
      );
    } else {
      addBowlerRuns(
        newBall.totalRuns,
        newBall.wicketType != null &&
            (newBall.wicketType == WicketType.bowled ||
                newBall.wicketType == WicketType.caught ||
                newBall.wicketType == WicketType.stumped ||
                newBall.wicketType == WicketType.hitWicket ||
                newBall.wicketType == WicketType.lbw),
        maiden,
        extraType,
      );
    }
    if (newBall.wicketType != null) {
      if (newBall.wicketType == WicketType.runOut) {
        wicketTakenBatsman(
          batsmanInvolved!,
          wicketType: wicketType,
          bowler: bowler,
          fielderInvolved: newBall.fielder,
          state
                  .matchCenterEntity!
                  .innings
                  .last
                  .oversData
                  .last
                  .legalDeliveries ==
              6,
        );
        state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == bowlingTeamPlayerInvolved!.playerId)
            .last
            .stats[inningsIndex]
            .runout++;
      } else if (newBall.wicketType == WicketType.caught) {
        wicketTakenBatsman(
          state.matchCenterEntity!.battingTeam!.onStrike!,
          wicketType: wicketType,
          bowler: bowler,
          fielderInvolved: newBall.fielder,
          state
                  .matchCenterEntity!
                  .innings
                  .last
                  .oversData
                  .last
                  .legalDeliveries ==
              6,
        );
        state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == bowlingTeamPlayerInvolved!.playerId)
            .last
            .stats[inningsIndex]
            .caught++;
      } else if (newBall.wicketType == WicketType.stumped) {
        wicketTakenBatsman(
          state.matchCenterEntity!.battingTeam!.onStrike!,
          wicketType: wicketType,
          bowler: bowler,
          fielderInvolved: newBall.fielder,
          state
                  .matchCenterEntity!
                  .innings
                  .last
                  .oversData
                  .last
                  .legalDeliveries ==
              6,
        );
        state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == bowlingTeamPlayerInvolved!.playerId)
            .last
            .stats[inningsIndex]
            .stumping++;
      } else {
        wicketTakenBatsman(
          state.matchCenterEntity!.battingTeam!.onStrike!,
          wicketType: wicketType,
          bowler: bowler,
          state
                  .matchCenterEntity!
                  .innings
                  .last
                  .oversData
                  .last
                  .legalDeliveries ==
              6,
        );
      }
    }
    final latestOver = state.matchCenterEntity!.innings.last.oversData.last;
    latestOver.player1Id = newBall.batsman!.playerId;
    latestOver.player1Name = newBall.batsman!.name;
    latestOver.player1balls = newBall.batsman!.stats[inningsIndex].balls;
    latestOver.player1runs = newBall.batsman!.stats[inningsIndex].runs;

    latestOver.player2Id = newBall.secondBatsman!.playerId;
    latestOver.player2Name = newBall.secondBatsman!.name;
    latestOver.player2balls = newBall.secondBatsman!.stats[inningsIndex].balls;
    latestOver.player2runs = newBall.secondBatsman!.stats[inningsIndex].runs;

    latestOver.bowlerId = newBall.bowler!.playerId;
    latestOver.bowlerName = newBall.bowler!.name;
    latestOver.bowlerOvers = newBall.bowler!.stats[inningsIndex].overs;
    latestOver.bowlerRuns = newBall.bowler!.stats[inningsIndex].runsGiven;
    latestOver.bowlerMaidens = newBall.bowler!.stats[inningsIndex].maidens;
    latestOver.bowlerWickets = newBall.bowler!.stats[inningsIndex].wickets;

    final inningsEnded = addInningsRuns(newBall);

    if (!inningsEnded &&
        state.matchCenterEntity!.innings.last.oversData.last.legalDeliveries ==
            6 &&
        wicketType == null) {
      setOnStrike(
        state.matchCenterEntity!.battingTeam!.currBatsmen
            .where(
              (e) =>
                  e!.playerId !=
                  state.matchCenterEntity!.battingTeam!.onStrike!.playerId,
            )
            .first!,
      );
      editBowler(null);
    }
    setWinner();
    print(
      prettifyJsonEncode(
        MatchCenterModel.fromEntity(state.matchCenterEntity!).toJson(),
      ),
    );
    emit(state.copyWith());
  }

  void prettyPrintJson(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(json);
    const chunkSize = 800; // prevents truncation

    for (var i = 0; i < prettyString.length; i += chunkSize) {
      print(
        prettyString.substring(
          i,
          i + chunkSize > prettyString.length
              ? prettyString.length
              : i + chunkSize,
        ),
      );
    }
  }

  Future<void> showAbandonMatchDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) async {
    int remainingSeconds = 5;
    Timer? timer;

    // Use StatefulBuilder to rebuild only the dialog when countdown updates
    await showDialog(
      context: context,
      barrierDismissible: false, // prevent accidental close
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            // Start timer when dialog first builds
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (remainingSeconds > 0) {
                setState(() => remainingSeconds--);
              } else {
                t.cancel();
              }
            });

            return AlertDialog(
              backgroundColor: ColorsConstants.defaultWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Abandon Match?",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              content: Text(
                "Do you really want to abandon the match?\n"
                "This action cannot be undone.",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(ctx).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: remainingSeconds > 0
                        ? ColorsConstants.onSurfaceGrey
                        : ColorsConstants.warningRed,
                    foregroundColor: ColorsConstants.defaultWhite,
                    disabledBackgroundColor: ColorsConstants.onSurfaceGrey,
                  ),
                  onPressed: remainingSeconds > 0
                      ? null
                      : () {
                          state.matchCenterEntity!.abandoned = true;
                          state.matchEntity!.abandoned = true;
                          timer?.cancel();
                          GoRouter.of(ctx).pop();
                          emit(state.copyWith());
                          onConfirm();
                        },
                  child: Text(
                    remainingSeconds > 0
                        ? "Yes, Abandon ($remainingSeconds)"
                        : "Yes, Abandon",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.defaultWhite,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    timer?.cancel();
  }

  void setWinner() {
    final matchCenter = state.matchCenterEntity!;
    final match = state.matchEntity!;

    // No winner logic for Test matches
    if (match.matchType == MatchType.test) {
      if (matchCenter.innings.length >= 3) {
        final target =
            state.matchCenterEntity!.innings[0].runs +
            state.matchCenterEntity!.innings[2].runs -
            state.matchCenterEntity!.innings[1].runs;

        if (matchCenter.innings.length == 3 &&
            target < 0 &&
            state.matchCenterEntity!.innings[2].wickets ==
                state.matchCenterEntity!.innings[2].battingTeam.players.length -
                    1) {
          matchCenter.winner =
              state.matchCenterEntity!.innings[1].battingTeam.id;
        } else if (matchCenter.innings.length == 4) {
          final firstInnings = matchCenter.innings[0];
          final secondInnings = matchCenter.innings[1];
          final thirdInnings = matchCenter.innings[2];
          final fourthInnings = matchCenter.innings[3];

          // Total players in the batting side
          final totalPlayers = fourthInnings.battingTeam.players.length;

          // Check winning conditions
          if (secondInnings.runs + fourthInnings.runs >
              firstInnings.runs + thirdInnings.runs) {
            // Chasing team won
            matchCenter.winner = secondInnings.battingTeam.id;
          } else if (fourthInnings.wickets == totalPlayers - 1) {
            // Chasing team all out or overs finished
            if (firstInnings.runs + thirdInnings.runs >
                secondInnings.runs + fourthInnings.runs) {
              matchCenter.winner = firstInnings.battingTeam.id;
            } else if (firstInnings.runs == secondInnings.runs) {
              matchCenter.winner = null;
            }
          } else {
            // Match still in progress
            matchCenter.winner = null;
          }
        }
      }

      return;
    }

    // Ensure both innings exist
    if (matchCenter.innings.length < 2) return;

    final firstInnings = matchCenter.innings[0];
    final secondInnings = matchCenter.innings[1];

    // Total players in the batting side
    final totalPlayers = secondInnings.battingTeam.players.length;

    // Check winning conditions
    if (secondInnings.runs > firstInnings.runs) {
      // Chasing team won
      matchCenter.winner = secondInnings.battingTeam.id;
    } else if (secondInnings.wickets == totalPlayers - 1 ||
        secondInnings.overs == matchCenter.overs.toString()) {
      // Chasing team all out or overs finished
      if (firstInnings.runs > secondInnings.runs) {
        matchCenter.winner = firstInnings.battingTeam.id;
      } else if (firstInnings.runs == secondInnings.runs) {
        matchCenter.winner = null;
      }
    } else {
      // Match still in progress
      matchCenter.winner = null;
    }

    emit(state.copyWith(matchCenterEntity: matchCenter));
  }

  undoLastBall() {
    final innings = state.matchCenterEntity!.innings.last;
    if (state.matchCenterEntity!.innings.last.oversData.last.balls.isEmpty) {
      state.matchCenterEntity!.innings.last.oversData.removeLast();
    }
    final balls = state.matchCenterEntity!.innings.last.oversData.last.balls;
    final undoBall = balls.last;
    if (innings.oversData.isEmpty) return; // safety

    final lastOver = innings.oversData.last;
    final over = state.matchCenterEntity!.innings.last.oversData.last;
    MatchPlayerEntity? otherBatsman;
    MatchPlayerEntity? batsmanInvolved;
    MatchPlayerEntity? bowlerInvolved;
    MatchPlayerEntity? fiedlerInvolved;
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    if (undoBall.batsman != null) {
      batsmanInvolved = state.matchCenterEntity!.battingTeam!.players
          .where((e) => e.playerId == undoBall.batsman!.playerId)
          .first;
    }
    if (undoBall.secondBatsman != null) {
      otherBatsman = state.matchCenterEntity!.battingTeam!.players
          .where((e) => e.playerId == undoBall.secondBatsman!.playerId)
          .first;
    }
    if (undoBall.bowler != null) {
      bowlerInvolved = state.matchCenterEntity!.bowlingTeam!.players
          .where((e) => e.playerId == undoBall.bowler!.playerId)
          .first;
    }
    if (undoBall.fielder != null) {
      fiedlerInvolved = state.matchCenterEntity!.bowlingTeam!.players
          .where((e) => e.playerId == undoBall.fielder!.playerId)
          .first;
    }
    if (undoBall.wicketType != null) {
      if (undoBall.wicketType == WicketType.runOut) {
        undoWicketTakenBatsman(
          batsmanInvolved!,
          otherBatsman!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
          fielderInvolved: fiedlerInvolved,
        );
        final fielder = state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == undoBall.fielder!.playerId)
            .last;
        if (fielder.stats[inningsIndex].runout > 0) {
          fielder.stats[inningsIndex].runout--;
        }
      } else if (undoBall.wicketType == WicketType.caught) {
        undoWicketTakenBatsman(
          batsmanInvolved!,
          otherBatsman!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
          fielderInvolved: fiedlerInvolved,
        );
        final fielder = state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == undoBall.fielder!.playerId)
            .last;
        if (fielder.stats[inningsIndex].caught > 0) {
          fielder.stats[inningsIndex].caught--;
        }
      } else if (undoBall.wicketType == WicketType.stumped) {
        undoWicketTakenBatsman(
          batsmanInvolved!,
          otherBatsman!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
          fielderInvolved: fiedlerInvolved,
        );
        final fielder = state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == undoBall.fielder!.playerId)
            .last;
        if (fielder.stats[inningsIndex].stumping > 0) {
          fielder.stats[inningsIndex].stumping--;
        }
      } else {
        undoWicketTakenBatsman(
          batsmanInvolved!,
          otherBatsman!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
        );
      }
    }

    if (!undoBall.isExtra) {
      if (undoBall.wicketType != null &&
          undoBall.wicketType == WicketType.retired) {
        undoStatsForBatsman(0, undoBall.extraType!, batsmanInvolved!, false);
      } else {
        undoStatsForBatsman(
          undoBall.runs,
          undoBall.extraType,
          batsmanInvolved!,
          true,
        );
      }
    } else if (undoBall.extraType == ExtraType.noBall) {
      undoStatsForBatsman(
        undoBall.runs,
        undoBall.extraType,
        batsmanInvolved!,
        false,
      );
    } else if (undoBall.extraType != ExtraType.bonus &&
        undoBall.extraType != ExtraType.penalty) {
      if (undoBall.extraType == ExtraType.moreRuns) {
        undoStatsForBatsman(
          undoBall.runs,
          undoBall.extraType,
          batsmanInvolved!,
          true,
        );
      } else {
        undoStatsForBatsman(0, undoBall.extraType, batsmanInvolved!, true);
      }
    }

    bool maiden = false;
    if (state.matchCenterEntity!.innings.last.oversData.last.overRuns == 0 &&
        state.matchCenterEntity!.innings.last.oversData.last.legalDeliveries ==
            6 &&
        state.matchCenterEntity!.innings.last.oversData.last.bowler.playerId ==
            undoBall.bowler!.playerId) {
      maiden = true;
    }

    if (undoBall.extraType != null &&
        (undoBall.extraType == ExtraType.legBye ||
            undoBall.extraType == ExtraType.bye)) {
      undoBowlerRuns(
        0,
        undoBall.wicketType != null &&
            (undoBall.wicketType == WicketType.bowled ||
                undoBall.wicketType == WicketType.caught ||
                undoBall.wicketType == WicketType.stumped ||
                undoBall.wicketType == WicketType.hitWicket ||
                undoBall.wicketType == WicketType.lbw),
        maiden,
        undoBall.extraType,
        bowlerInvolved!,
      );
    } else {
      undoBowlerRuns(
        undoBall.totalRuns,
        undoBall.wicketType != null &&
            (undoBall.wicketType == WicketType.bowled ||
                undoBall.wicketType == WicketType.caught ||
                undoBall.wicketType == WicketType.stumped ||
                undoBall.wicketType == WicketType.hitWicket ||
                undoBall.wicketType == WicketType.lbw),
        maiden,
        undoBall.extraType,
        bowlerInvolved!,
      );
    }
    final latestOver = state.matchCenterEntity!.innings.last.oversData.last;
    latestOver.player1Id = undoBall.batsman!.playerId;
    latestOver.player1Name = undoBall.batsman!.name;
    latestOver.player1balls = undoBall.batsman!.stats[inningsIndex].balls;
    latestOver.player1runs = undoBall.batsman!.stats[inningsIndex].runs;

    latestOver.player2Id = undoBall.secondBatsman!.playerId;
    latestOver.player2Name = undoBall.secondBatsman!.name;
    latestOver.player2balls = undoBall.secondBatsman!.stats[inningsIndex].balls;
    latestOver.player2runs = undoBall.secondBatsman!.stats[inningsIndex].runs;

    latestOver.bowlerId = undoBall.bowler!.playerId;
    latestOver.bowlerName = undoBall.bowler!.name;
    latestOver.bowlerOvers = undoBall.bowler!.stats[inningsIndex].overs;
    latestOver.bowlerRuns = undoBall.bowler!.stats[inningsIndex].runsGiven;
    latestOver.bowlerMaidens = undoBall.bowler!.stats[inningsIndex].maidens;
    latestOver.bowlerWickets = undoBall.bowler!.stats[inningsIndex].wickets;

    if (lastOver.balls.length == 1 && innings.oversData.length == 1) {
      innings.oversData.removeLast();
      if (innings.oversData.isNotEmpty) {
        editBowler(innings.oversData.last.bowler);
      }
    } else if (lastOver.balls.length == 1 && lastOver.legalDeliveries == 0) {
      innings.oversData.removeLast();
      if (innings.oversData.isNotEmpty) {
        editBowler(innings.oversData.last.bowler);
      }
    } else {
      lastOver.balls.removeLast();
      editBowler(innings.oversData.last.bowler);
    }
    removeInningsRuns(undoBall);
    setWinner();
    emit(state.copyWith());
  }

  void endInnings() {
    final match = state.matchCenterEntity!;
    final format = match.matchType;
    final inningsCount = match.innings.length;

    // 🏏 LIMITED OVERS MATCH (2 innings max)
    if (format != MatchType.test) {
      if (inningsCount == 1) {
        match.innings.add(
          InningsEntity(
            battingTeam: match.bowlingTeam!,
            runs: 0,
            wickets: 0,
            overs: "0",
            number: 2,
            crr: 0,
            extras: 0,
            oversData: [],
          ),
        );
      } else {
        // Match complete after 2 innings
        match.winner = Methods.getWinner(match);
      }

      emit(state.copyWith(matchCenterEntity: match));
      return;
    }

    // TEST MATCH (Up to 4 innings)
    if (format == MatchType.test) {
      if (inningsCount < 4) {
        if (inningsCount == 3) {
          final target =
              state.matchCenterEntity!.innings[0].runs +
              state.matchCenterEntity!.innings[2].runs -
              state.matchCenterEntity!.innings[1].runs;
          if (target < 0) {
            match.winner = Methods.getWinner(match);
          } else {
            final nextBattingTeam = match.bowlingTeam!;

            match.innings.add(
              InningsEntity(
                battingTeam: nextBattingTeam,
                runs: 0,
                wickets: 0,
                overs: "0",
                number: inningsCount + 1,
                crr: 0,
                extras: 0,
                oversData: [],
              ),
            );
            match.teamA.currBatsmen = [null, null];
            match.teamA.bowler = null;
            match.teamA.onStrike = null;
            match.teamB.currBatsmen = [null, null];
            match.teamB.bowler = null;
            match.teamB.onStrike = null;
            for (var player in match.teamA.players) {
              player.stats.add(
                MatchPlayerStatsEntity(
                  runs: 0,
                  balls: 0,
                  n4s: 0,
                  n6s: 0,
                  sr: 0,
                  overs: "0",
                  runsGiven: 0,
                  maidens: 0,
                  wickets: 0,
                  eco: 0,
                  out: false,
                  caught: 0,
                  stumping: 0,
                  runout: 0,
                ),
              );
            }
            for (var player in match.teamB.players) {
              player.stats.add(
                MatchPlayerStatsEntity(
                  runs: 0,
                  balls: 0,
                  n4s: 0,
                  n6s: 0,
                  sr: 0,
                  overs: "0",
                  runsGiven: 0,
                  maidens: 0,
                  wickets: 0,
                  eco: 0,
                  out: false,
                  caught: 0,
                  stumping: 0,
                  runout: 0,
                ),
              );
            }
          }
        } else {
          final nextBattingTeam = match.bowlingTeam!;

          match.innings.add(
            InningsEntity(
              battingTeam: nextBattingTeam,
              runs: 0,
              wickets: 0,
              overs: "0",
              number: inningsCount + 1,
              crr: 0,
              extras: 0,
              oversData: [],
            ),
          );
          match.teamA.currBatsmen = [null, null];
          match.teamA.bowler = null;
          match.teamA.onStrike = null;
          match.teamB.currBatsmen = [null, null];
          match.teamB.bowler = null;
          match.teamB.onStrike = null;
          for (var player in match.teamA.players) {
            player.stats.add(
              MatchPlayerStatsEntity(
                runs: 0,
                balls: 0,
                n4s: 0,
                n6s: 0,
                sr: 0,
                overs: "0",
                runsGiven: 0,
                maidens: 0,
                wickets: 0,
                eco: 0,
                out: false,
                caught: 0,
                stumping: 0,
                runout: 0,
              ),
            );
          }
          for (var player in match.teamB.players) {
            player.stats.add(
              MatchPlayerStatsEntity(
                runs: 0,
                balls: 0,
                n4s: 0,
                n6s: 0,
                sr: 0,
                overs: "0",
                runsGiven: 0,
                maidens: 0,
                wickets: 0,
                eco: 0,
                out: false,
                caught: 0,
                stumping: 0,
                runout: 0,
              ),
            );
          }
        }
      } else {
        // After 4 innings, match ends — decide winner or draw
        match.winner = Methods.getWinner(match);
      }

      emit(state.copyWith(matchCenterEntity: match));
    }
  }

  void changeTab(int index) {
    final newLoadedTabs = {...state.loadedTabs, index};
    emit(state.copyWith(currentIndex: index, loadedTabs: newLoadedTabs));
  }
}
