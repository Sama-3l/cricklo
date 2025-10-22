import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentBowlStatsScreen extends StatelessWidget {
  const TournamentBowlStatsScreen({super.key});

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
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Wkt", "Inn", "Avg"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["BBO", "Ove", "Eco"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Avg", "Inn", "Wkt"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Eco", "Bal", "Runs"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Mai", "Balls", "Runs"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Balls", "Inn", "Eco"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["3w", "Runs", "Inn"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["5w", "Runs", "Inn"],
                  ),
                  LeaderboardTable(
                    team: "Aviral All Stars",
                    headings: ["Dots", "Balls", "Runs"],
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
