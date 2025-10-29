import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/domain/entities/leaderboard_row_data_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatStatsScreen extends StatelessWidget {
  const BatStatsScreen({super.key});

  List<LeaderboardRowData> generateLeaderboardData(
    BuildContext context,
    int type,
  ) {
    final cubit = context.read<TeamPageCubit>();
    final team = cubit.state.team;

    if (team == null || team.battingStats.isEmpty) return [];

    final battingStats = team.battingStats;

    // Helper to format double values neatly
    String formatDouble(double value) =>
        value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);

    List<LeaderboardRowData> data = [];

    switch (type) {
      // 0️⃣ Most Runs → Runs, Inn, Avg
      case 0:
        final sorted = [...battingStats]
          ..sort((a, b) => b.runs.compareTo(a.runs));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.runs}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 1️⃣ Highest Score → Run, Ball, SR
      case 1:
        final sorted = [...battingStats]
          ..sort((a, b) => b.runs.compareTo(a.runs));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.runs}', '${p.balls}', formatDouble(p.strikeRate)],
          );
        });
        break;

      // 2️⃣ Batting Avg → Avg, Inn, Runs
      case 2:
        final sorted = [...battingStats]
          ..sort((a, b) => b.average.compareTo(a.average));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: [formatDouble(p.average), '${p.matches}', '${p.runs}'],
          );
        });
        break;

      // 3️⃣ Strike Rate → SR, Inn, Runs
      case 3:
        final sorted = [...battingStats]
          ..sort((a, b) => b.strikeRate.compareTo(a.strikeRate));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: [formatDouble(p.strikeRate), '${p.matches}', '${p.runs}'],
          );
        });
        break;

      // 4️⃣ Most 4s → 4s, Inn, Avg
      case 4:
        final sorted = [...battingStats]
          ..sort((a, b) => b.fours.compareTo(a.fours));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.fours}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 5️⃣ Most 6s → 6s, Inn, Avg
      case 5:
        final sorted = [...battingStats]
          ..sort((a, b) => b.sixes.compareTo(a.sixes));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.sixes}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 6️⃣ Most 30s → 30s, Inn, Avg
      case 6:
        final sorted = [...battingStats]
          ..sort((a, b) => b.thirties.compareTo(a.thirties));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.thirties}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 7️⃣ Most 50s → 50s, Inn, Avg
      case 7:
        final sorted = [...battingStats]
          ..sort((a, b) => b.fifties.compareTo(a.fifties));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.fifties}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 8️⃣ Most 100s → 100s, Inn, Avg
      case 8:
        final sorted = [...battingStats]
          ..sort((a, b) => b.hundreds.compareTo(a.hundreds));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.hundreds}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 9️⃣ Balls Faced → Balls, Inn, Runs
      case 9:
        final sorted = [...battingStats]
          ..sort((a, b) => b.balls.compareTo(a.balls));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.player.name,
            stats: ['${p.balls}', '${p.matches}', '${p.runs}'],
          );
        });
        break;
    }

    return data;
  }

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
            mainTabs: const [
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),

          // 🟩 Dynamic Leaderboard per Tab
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IndexedStack(
                index: state.selectedStatsTabTableType,
                children: List.generate(10, (index) {
                  final data = generateLeaderboardData(context, index);
                  final headings = [
                    ["Runs", "Inn", "Avg"],
                    ["Runs", "Ball", "SR"],
                    ["Avg", "Inn", "Runs"],
                    ["SR", "Inn", "Runs"],
                    ["4s", "Inn", "Avg"],
                    ["6s", "Inn", "Avg"],
                    ["30s", "Inn", "Avg"],
                    ["50s", "Inn", "Avg"],
                    ["100s", "Inn", "Avg"],
                    ["Balls", "Inn", "Runs"],
                  ][index];

                  return LeaderboardTable(headings: headings, data: data);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
