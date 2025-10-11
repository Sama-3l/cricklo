import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/innings_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_stats_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_entity.dart';
import 'package:flutter/material.dart';

part 'scorer_match_center_state.dart';

class ScorerMatchCenterCubit extends Cubit<ScorerMatchCenterState> {
  ScorerMatchCenterCubit()
    : super(ScorerMatchCenterUpdate(currentIndex: 0, loadedTabs: {0}));

  init(MatchEntity matchEntity) {
    final matchCenterEntity = MatchCenterEntity(
      matchID: matchEntity.matchID,
      dateAndTime: matchEntity.dateAndTime,
      overs: matchEntity.overs,
      matchType: matchEntity.matchType,
      tossWinner: matchEntity.tossWinner,
      tossChoice: matchEntity.tossChoice,
      teamA: MatchTeamEntity(
        id: matchEntity.teamA.id,
        name: matchEntity.teamA.name,
        teamLogo: matchEntity.teamA.teamLogo,
        teamBanner: matchEntity.teamA.teamBanner,
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
        partnerships: [],
      ),
    );
    emit(state.copyWith(matchCenterEntity: matchCenterEntity));
  }

  addBatsman(List<MatchPlayerEntity> batsman) {
    if (state.matchCenterEntity!.battingTeam!.currBatsmen != null) {
      state.matchCenterEntity!.battingTeam!.currBatsmen!.addAll(batsman);
    } else {
      state.matchCenterEntity!.battingTeam!.currBatsmen = batsman;
    }
    if (batsman.length == 2) {
      setOnStrike(batsman[0]);
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

  addRunsToBatsman(int runs) {
    final onStrike = state.matchCenterEntity!.battingTeam!.onStrike;
    onStrike!.stats.runs += runs;
    onStrike.stats.balls += 1;
    if (runs == 4) {
      onStrike.stats.n4s++;
    }
    if (runs == 6) {
      onStrike.stats.n6s++;
    }
    onStrike.stats.sr = (onStrike.stats.runs / onStrike.stats.balls) * 100;
    if (runs.isOdd) {
      setOnStrike(
        state.matchCenterEntity!.battingTeam!.currBatsmen!
            .where((e) => e.playerId != onStrike.playerId)
            .first,
      );
    }
  }

  addBowlerRuns(int runs, bool wicket, bool maiden) {
    final bowler = state.matchCenterEntity!.bowlingTeam!.bowler;
    bowler!.stats.overs = Methods.incrementOver(bowler.stats.overs);
    bowler.stats.runsGiven += runs;
    if (wicket) {
      bowler.stats.wickets++;
    }
    if (maiden) bowler.stats.maidens++;
    final oversDecimal = Methods.oversToDecimal(bowler.stats.overs);
    bowler.stats.eco = oversDecimal == 0
        ? 0
        : (bowler.stats.runsGiven / oversDecimal);
  }

  addInningsRuns(BallEntity ball) {
    state.matchCenterEntity!.innings.last.runs += ball.totalRuns;
    if (!ball.isExtra) {
      state.matchCenterEntity!.innings.last.overs = Methods.incrementOver(
        state.matchCenterEntity!.innings.last.overs,
      );
    }
    final oversDecimal = Methods.oversToDecimal(
      state.matchCenterEntity!.innings.last.overs,
    );
    state.matchCenterEntity!.innings.last.crr = oversDecimal == 0
        ? 0
        : state.matchCenterEntity!.innings.last.runs / oversDecimal;
    if (ball.isExtra) {
      state.matchCenterEntity!.innings.last.extras += ball.extraRuns;
    }
    if (ball.wicketType != null) {
      state.matchCenterEntity!.innings.last.wickets++;
    }
  }

  addBall(
    int runs,
    bool isExtra, {
    ExtraType? extraType,
    WicketType? wicketType,
    int? sector,
  }) {
    final newBall = BallEntity(
      runs: runs,
      isExtra: isExtra,
      extraType: extraType,
      wicketType: wicketType,
      sector: sector,
    );
    final battingTeam = state.matchCenterEntity!.battingTeam;
    final bowler = state.matchCenterEntity!.bowlingTeam!.bowler;
    if (state.matchCenterEntity!.innings.last.oversData.isEmpty) {
      state.matchCenterEntity!.innings.last.oversData.add(
        OversEntity(
          overNumber: 1,
          teamEntity: battingTeam!,
          bowler: bowler!,
          balls: [newBall],
        ),
      );
    } else {
      final lastOver = state.matchCenterEntity!.innings.last.oversData.last;
      if (lastOver.legalDeliveries == 6) {
        state.matchCenterEntity!.innings.last.oversData.add(
          OversEntity(
            overNumber: state.matchCenterEntity!.innings.length + 1,
            teamEntity: battingTeam!,
            bowler: bowler!,
            balls: [newBall],
          ),
        );
      } else {
        state.matchCenterEntity!.innings.last.oversData.last.balls.add(newBall);
      }
    }
    if (!newBall.isExtra || newBall.extraType == ExtraType.noBall) {
      addRunsToBatsman(runs);
    }
    bool maiden = false;
    if (state.matchCenterEntity!.innings.last.oversData.last.overRuns == 0) {
      maiden = true;
    }
    if (newBall.extraType != null &&
        (newBall.extraType == ExtraType.legBye ||
            newBall.extraType == ExtraType.bye)) {
      addBowlerRuns(
        0,
        newBall.wicketType != null &&
            !(newBall.wicketType == WicketType.bowled ||
                newBall.wicketType == WicketType.caught ||
                newBall.wicketType == WicketType.stumped ||
                newBall.wicketType == WicketType.hitWicket ||
                newBall.wicketType == WicketType.lbw),
        maiden,
      );
    } else {
      addBowlerRuns(
        newBall.totalRuns,
        newBall.wicketType != null &&
            !(newBall.wicketType == WicketType.bowled ||
                newBall.wicketType == WicketType.caught ||
                newBall.wicketType == WicketType.stumped ||
                newBall.wicketType == WicketType.hitWicket ||
                newBall.wicketType == WicketType.lbw),
        maiden,
      );
    }
    addInningsRuns(newBall);
    if (state.matchCenterEntity!.innings.last.oversData.last.legalDeliveries ==
        6) {
      setOnStrike(
        state.matchCenterEntity!.battingTeam!.currBatsmen!
            .where(
              (e) =>
                  e.playerId !=
                  state.matchCenterEntity!.battingTeam!.onStrike!.playerId,
            )
            .first,
      );
      editBowler(null);
    }
    emit(state.copyWith());
  }

  void changeTab(int index) {
    final newLoadedTabs = {...state.loadedTabs, index};
    emit(state.copyWith(currentIndex: index, loadedTabs: newLoadedTabs));
  }
}
