import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/presentation/screens/entity_matches_page.dart';
import 'package:cricklo/features/teams/domain/entities/partnership_stats_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_stats/overall_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_stats/partnerships_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamStatsScreens extends StatelessWidget {
  const TeamStatsScreens({super.key});

  Map<String, List<MatchEntity>> getTeamChasesAndDefences(
    String teamId,
    List<MatchEntity> matches,
  ) {
    matches = matches.where((e) => e.tossChoice != null).toList();
    final List<MatchEntity> chases = [];
    final List<MatchEntity> defences = [];

    for (final match in matches) {
      final isTeamA = match.teamA.id == teamId;
      final isTeamB = match.teamB.id == teamId;

      if (!isTeamA && !isTeamB) continue; // skip unrelated matches

      // Determine who batted first
      String? firstBattingTeamId;

      if (match.tossWinner != null && match.tossChoice != null) {
        // If toss winner chose to bat, they bat first
        if (match.tossChoice == TossChoice.batting) {
          firstBattingTeamId = match.tossWinner!;
        } else {
          // Toss winner chose to bowl, so the other team bats first
          firstBattingTeamId = (match.tossWinner == match.teamA.id)
              ? match.teamB.id
              : match.teamA.id;
        }
      }

      // Classify as chase or defence
      if (firstBattingTeamId == teamId) {
        defences.add(match);
      } else {
        chases.add(match);
      }
    }

    return {"chases": chases, "defences": defences};
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    final state = cubit.state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileTabBar(
            onTap: (index) => cubit.changeStatsTabTable(index),
            mainTabs: ["Overall", "Partnerships", "Chases", "Defences"],
            selectedMainTab: state.selectedStatsTabTableType,
            height: 32,
            fontsize: 10,
            row: true,
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),

          Expanded(
            child: IndexedStack(
              index: state.selectedStatsTabTableType,
              children: [
                OverallScreen(),
                PartnershipsScreen(
                  partnerships: state.loading
                      ? <PartnershipStatsEntity>[]
                      : state.team!.partnershipStats
                            .where(
                              (e) =>
                                  e.totalRuns ==
                                  e.batsman1Runs + e.batsman2Runs,
                            )
                            .toList(),
                ),
                EntityMatchesPage(
                  matches: getTeamChasesAndDefences(
                    state.team!.id,
                    state.team!.matches,
                  )["chases"]!,
                  title: "Chases",
                  removePadding: true,
                  whiteTile: true,
                  loading: state.loading,
                ),
                EntityMatchesPage(
                  matches: getTeamChasesAndDefences(
                    state.team!.id,
                    state.team!.matches,
                  )["defences"]!,
                  title: "Defences",
                  removePadding: true,
                  whiteTile: true,
                  loading: state.loading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
