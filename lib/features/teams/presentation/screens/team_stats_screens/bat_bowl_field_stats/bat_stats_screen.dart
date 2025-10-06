import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatStatsScreen extends StatelessWidget {
  const BatStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    final state = cubit.state;
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
                  LeaderboardTable(headings: ["Runs", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["Runs", "Ball", "SR"]),
                  LeaderboardTable(headings: ["Avg", "Inn", "Runs"]),
                  LeaderboardTable(headings: ["SR", "Inn", "Runs"]),
                  LeaderboardTable(headings: ["4s", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["6s", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["30s", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["50s", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["100s", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["Balls", "Inn", "Runs"]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
