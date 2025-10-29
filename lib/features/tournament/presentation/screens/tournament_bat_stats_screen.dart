import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentBatStatsScreen extends StatelessWidget {
  const TournamentBatStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileTabBar(
            onTap: (index) => cubit.changeStatsTabTable(index),
            mainTabs: [
              "Most Runs", // Runs, Inn, Avg
              "Highest Score", // Run, Ball, SR
              "Batting Avg",
              "Strike Rate",
              "Most 4s",
              "Most 6s",
              "Most 30s",
              "Most 50s",
              "Most 100s",
              "Balls Faced",
            ],
            selectedMainTab: state.selectedStatsTabTableType,
            height: 32,
            fontsize: 10,
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IndexedStack(
                index: state.selectedStatsTabTableType,
                children: [
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Runs", "Inn", "Avg"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Runs", "Ball", "SR"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Avg", "Inn", "Runs"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["SR", "Inn", "Runs"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["4s", "Inn", "Avg"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["6s", "Inn", "Avg"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["30s", "Inn", "Avg"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["50s", "Inn", "Avg"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["100s", "Inn", "Avg"],
                    data: [],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Balls", "Inn", "Runs"],
                    data: [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
