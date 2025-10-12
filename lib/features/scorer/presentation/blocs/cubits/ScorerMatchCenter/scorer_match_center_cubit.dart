import 'dart:async';

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
import 'package:flutter/material.dart';
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
                id: e.id,
                playerId: e.playerId,
                name: e.name,
                captain: e.captain,
                teamRole: e.teamRole,
                playerType: e.playerType,
                batterType: e.batterType,
                bowlerType: e.bowlerType,
                stats: MatchPlayerStatsEntity(
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
                id: e.id,
                playerId: e.playerId,
                name: e.name,
                captain: e.captain,
                teamRole: e.teamRole,
                playerType: e.playerType,
                batterType: e.batterType,
                bowlerType: e.bowlerType,
                stats: MatchPlayerStatsEntity(
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
              ),
            )
            .toList(),
        location: matchEntity.teamB.location,
        battingOrder: {},
      ),
      location: matchEntity.location,
      scorer: MatchScorerEntity(
        playerId: matchEntity.scorer.id,
        name: matchEntity.scorer.name,
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
    onStrike!.stats.runs += runs;
    onStrike.stats.balls++;
    addRunsToPartnership(runs, ballCounted);
    if (runs == 4) {
      if ((extraType != null && (extraType == ExtraType.noBall))) {
        onStrike.stats.n4s++;
      } else if (extraType == null) {
        onStrike.stats.n4s++;
      }
    }
    if (runs == 6) {
      if ((extraType != null && (extraType == ExtraType.noBall))) {
        onStrike.stats.n6s++;
      } else if (extraType == null) {
        onStrike.stats.n6s++;
      }
    }
    onStrike.stats.sr = (onStrike.stats.runs / onStrike.stats.balls) * 100;
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
    if (extraType != null) {
      if (extraType == ExtraType.legBye || extraType == ExtraType.bye) {
        bowler!.stats.overs = Methods.incrementOver(bowler.stats.overs);
        bowler.stats.runsGiven += runs;
      } else if (extraType != ExtraType.bonus &&
          extraType != ExtraType.penalty) {
        if (extraType == ExtraType.moreRuns) {
          bowler!.stats.overs = Methods.incrementOver(bowler.stats.overs);
        }
        bowler!.stats.runsGiven += runs;
      }
    } else {
      bowler!.stats.overs = Methods.incrementOver(bowler.stats.overs);
      bowler.stats.runsGiven += runs;
    }
    if (wicket) {
      bowler!.stats.wickets++;
    }
    if (maiden) bowler!.stats.maidens++;
    final oversDecimal = Methods.oversToDecimal(bowler!.stats.overs);
    bowler.stats.eco = oversDecimal == 0
        ? 0
        : (bowler.stats.runsGiven / oversDecimal);
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
    if (state.matchCenterEntity!.innings.last.overs.length >
            state.matchCenterEntity!.overs ||
        state.matchCenterEntity!.innings.last.wickets ==
            state.matchCenterEntity!.innings.last.battingTeam.players.length -
                1) {
      print("endInnings");
      endInnings();
      return true;
    }
    return false;
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

    // 2️⃣ Subtract runs and ball
    onStrike.stats.runs -= runs;
    if (onStrike.stats.balls > 0) {
      onStrike.stats.balls--;
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
      if (onStrike.stats.n4s > 0) onStrike.stats.n4s--;
    }
    if (runs == 6 && (extraType == null || extraType == ExtraType.noBall)) {
      if (onStrike.stats.n6s > 0) onStrike.stats.n6s--;
    }

    // 5️⃣ Recompute strike rate
    if (onStrike.stats.balls > 0) {
      onStrike.stats.sr = (onStrike.stats.runs / onStrike.stats.balls) * 100;
    } else {
      onStrike.stats.sr = 0;
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
    if (extraType != null) {
      if (extraType == ExtraType.legBye || extraType == ExtraType.bye) {
        bowler.stats.overs = Methods.decrementOver(bowler.stats.overs);
        bowler.stats.runsGiven -= runs;
      } else if (extraType != ExtraType.bonus &&
          extraType != ExtraType.penalty) {
        if (extraType == ExtraType.moreRuns) {
          bowler.stats.overs = Methods.decrementOver(bowler.stats.overs);
        }
        bowler.stats.runsGiven -= runs;
      }
    } else {
      bowler.stats.overs = Methods.decrementOver(bowler.stats.overs);
      bowler.stats.runsGiven -= runs;
    }

    // Reverse wicket if previously counted
    if (wicket && bowler.stats.wickets > 0) {
      bowler.stats.wickets--;
    }

    // Reverse maiden if previously counted
    if (maiden && bowler.stats.maidens > 0) {
      bowler.stats.maidens--;
    }

    // Recalculate economy
    final oversDecimal = Methods.oversToDecimal(bowler.stats.overs);
    bowler.stats.eco = oversDecimal == 0
        ? 0
        : (bowler.stats.runsGiven / oversDecimal);

    emit(state.copyWith());
  }

  undoWicketTakenBatsman(
    MatchPlayerEntity overBatsman,
    MatchPlayerEntity batsman,
    bool lastDelivery, {
    WicketType? wicketType,
    MatchPlayerEntity? overBowler,
    MatchPlayerEntity? bowler,
    MatchPlayerEntity? overFielder,
    MatchPlayerEntity? fielderInvolved,
  }) {
    final currBatsmen = state.matchCenterEntity!.battingTeam!.currBatsmen;
    final partnerships = state.matchCenterEntity!.battingTeam!.partnerships;

    final last = partnerships[partnerships.length - 1];
    final secondLast = partnerships[partnerships.length - 2];

    late final MatchPlayerEntity? repeatedPlayer;
    if (last.player1!.playerId == secondLast.player1!.playerId ||
        last.player1!.playerId == secondLast.player2!.playerId) {
      repeatedPlayer = last.player1;
    } else if (last.player2!.playerId == secondLast.player1!.playerId ||
        last.player2!.playerId == secondLast.player2!.playerId) {
      repeatedPlayer = last.player2;
    }
    // print(repeatedPlayer!.name);
    // print(currBatsmen[0]!.name);
    // print(currBatsmen[1]!.name);
    // Re-add batsman to the slot where he was removed
    if (currBatsmen[0]!.playerId == repeatedPlayer!.playerId) {
      currBatsmen[1] = batsman;
    } else {
      currBatsmen[0] = batsman;
    }
    state.matchCenterEntity!.battingTeam!.partnerships.removeLast();
    // print(currBatsmen[0]!.name);
    // Reverse lastDelivery strike change and bowler edit
    if (lastDelivery) {
      if (batsman.playerId ==
          state.matchCenterEntity!.battingTeam!.currBatsmen[0]!.playerId) {
        setOnStrike(state.matchCenterEntity!.battingTeam!.currBatsmen[1]!);
      } else {
        setOnStrike(state.matchCenterEntity!.battingTeam!.currBatsmen[0]!);
      }
      // Revert editBowler(null)
      editBowler(bowler);
    }

    // Revert batsman’s out status and wicket info
    for (var player in state.matchCenterEntity!.battingTeam!.players) {
      if (player.playerId == batsman.playerId) {
        player.stats.out = false;
        player.stats.wicketType = null;
        player.stats.bowler = null;
        player.stats.fielder = null;
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

    for (var player in state.matchCenterEntity!.battingTeam!.players) {
      if (player.playerId == batsmen.playerId) {
        player.stats.out = true;
        player.stats.wicketType = wicketType;
        player.stats.bowler = bowler!.name;
        if (fielderInvolved != null) {
          player.stats.fielder = fielderInvolved.name;
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
    final battingTeam = state.matchCenterEntity!.battingTeam!;
    final bowler = state.matchCenterEntity!.bowlingTeam!.bowler;
    if (state.matchCenterEntity!.innings.last.oversData.isEmpty) {
      state.matchCenterEntity!.innings.last.oversData.add(
        OversEntity(
          runs: state.matchCenterEntity!.innings.last.runs,
          wickets: state.matchCenterEntity!.innings.last.wickets,
          overNumber: 1,
          teamEntity: battingTeam,
          bowler: bowler!,
          balls: [newBall],
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
            teamEntity: battingTeam,
            bowler: bowler!,
            balls: [newBall],
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
            .stats
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
            .stats
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
            .stats
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
    newBall.batsman = newBall.batsman?.copyWith();
    newBall.secondBatsman = newBall.secondBatsman?.copyWith();
    newBall.bowler = newBall.bowler?.copyWith();
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

    emit(state.copyWith());
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
    if (match.matchType == MatchType.test) return;

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
    MatchPlayerEntity? batsmanInvolved;
    MatchPlayerEntity? secondBatsmanInvolved;
    MatchPlayerEntity? bowlerInvolved;
    MatchPlayerEntity? fiedlerInvolved;
    if (undoBall.batsman != null) {
      batsmanInvolved = state.matchCenterEntity!.battingTeam!.players
          .where((e) => e.playerId == undoBall.batsman!.playerId)
          .first;
    }
    if (undoBall.bowler != null) {
      bowlerInvolved = state.matchCenterEntity!.bowlingTeam!.players
          .where((e) => e.playerId == undoBall.bowler!.playerId)
          .first;
    }
    if (undoBall.secondBatsman != null) {
      secondBatsmanInvolved = state.matchCenterEntity!.battingTeam!.players
          .where((e) => e.playerId == undoBall.secondBatsman!.playerId)
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
          undoBall.batsman!,
          batsmanInvolved!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
          fielderInvolved: fiedlerInvolved,
        );
        final fielder = state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == undoBall.fielder!.playerId)
            .last;
        if (fielder.stats.runout > 0) fielder.stats.runout--;
      } else if (undoBall.wicketType == WicketType.caught) {
        undoWicketTakenBatsman(
          undoBall.batsman!,
          batsmanInvolved!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
          fielderInvolved: fiedlerInvolved,
        );
        final fielder = state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == undoBall.fielder!.playerId)
            .last;
        if (fielder.stats.caught > 0) fielder.stats.caught--;
      } else if (undoBall.wicketType == WicketType.stumped) {
        undoWicketTakenBatsman(
          undoBall.batsman!,
          batsmanInvolved!,
          over.legalDeliveries == 0 ? true : false,
          wicketType: undoBall.wicketType,
          bowler: bowlerInvolved,
          fielderInvolved: fiedlerInvolved,
        );
        final fielder = state.matchCenterEntity!.bowlingTeam!.players
            .where((e) => e.playerId == undoBall.fielder!.playerId)
            .last;
        if (fielder.stats.stumping > 0) fielder.stats.stumping--;
      } else {
        undoWicketTakenBatsman(
          undoBall.batsman!,
          batsmanInvolved!,
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

  endInnings() {
    final format = state.matchCenterEntity!.matchType;
    if (format != MatchType.test &&
        state.matchCenterEntity!.innings.length == 1) {
      state.matchCenterEntity!.innings.add(
        InningsEntity(
          battingTeam: state.matchCenterEntity!.bowlingTeam!,
          runs: 0,
          wickets: 0,
          overs: "0",
          number: 2,
          crr: 0,
          extras: 0,
          oversData: [],
        ),
      );
      state.copyWith();
    }
  }

  void changeTab(int index) {
    final newLoadedTabs = {...state.loadedTabs, index};
    emit(state.copyWith(currentIndex: index, loadedTabs: newLoadedTabs));
  }
}
