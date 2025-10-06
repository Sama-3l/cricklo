import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BowlStatsScreen extends StatelessWidget {
  const BowlStatsScreen({super.key});

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
              "Wickets",
              "Best Bowling",
              "Bowling Average",
              "Economy",
              "Maidens",
              "Balls Bowled",
              "Most 3w",
              "Most 5w",
              "Dots",
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
                  LeaderboardTable(headings: ["Wkt", "Inn", "Avg"]),
                  LeaderboardTable(headings: ["BBO", "Ove", "Eco"]),
                  LeaderboardTable(headings: ["Avg", "Inn", "Wkt"]),
                  LeaderboardTable(headings: ["Eco", "Bal", "Runs"]),
                  LeaderboardTable(headings: ["Mai", "Balls", "Runs"]),
                  LeaderboardTable(headings: ["Balls", "Inn", "Eco"]),
                  LeaderboardTable(headings: ["3w", "Runs", "Inn"]),
                  LeaderboardTable(headings: ["5w", "Runs", "Inn"]),
                  LeaderboardTable(headings: ["Dots", "Balls", "Runs"]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
