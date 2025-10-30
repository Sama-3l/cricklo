import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/domain/entities/leaderboard_row_data_entity.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentBowlStatsScreen extends StatelessWidget {
  const TournamentBowlStatsScreen({super.key});

  List<LeaderboardRowData> generateLeaderboardData(
    BuildContext context,
    int type,
  ) {
    final cubit = context.read<TournamentCubit>();
    final team = cubit.state.tournamentEntity;

    if (team == null || team.bowlingStats.isEmpty) return [];

    final bowlingStats = team.bowlingStats;

    String formatDouble(double value) =>
        value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);

    List<LeaderboardRowData> data = [];

    switch (type) {
      // 0️⃣ Wickets → Wkt, Inn, Avg
      case 0:
        final sorted = [...bowlingStats]
          ..sort((a, b) => b.wickets.compareTo(a.wickets));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: ['${p.wickets}', '${p.matches}', formatDouble(p.average)],
          );
        });
        break;

      // 1️⃣ Bowling Average → Avg, Inn, Wkt
      case 1:
        final sorted = [...bowlingStats]
          ..sort((a, b) => a.average.compareTo(b.average));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: [formatDouble(p.average), '${p.matches}', '${p.wickets}'],
          );
        });
        break;

      // 2️⃣ Economy → Eco, Bal, Runs
      case 2:
        final sorted = [...bowlingStats]
          ..sort((a, b) => a.economy.compareTo(b.economy));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          final balls = (p.overs * 6).round();
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: [formatDouble(p.economy), '$balls', '${p.runs}'],
          );
        });
        break;

      // 3️⃣ Maidens → Mai, Balls, Runs
      case 3:
        final sorted = [...bowlingStats]
          ..sort((a, b) => b.maidens.compareTo(a.maidens));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          final balls = (p.overs * 6).round();
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: ['${p.maidens}', '$balls', '${p.runs}'],
          );
        });
        break;

      // 4️⃣ Balls Bowled → Balls, Inn, Eco
      case 4:
        final sorted = [...bowlingStats]
          ..sort((a, b) => b.overs.compareTo(a.overs));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          final balls = (p.overs * 6).round();
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: ['$balls', '${p.matches}', formatDouble(p.economy)],
          );
        });
        break;

      // 5️⃣ Most 3w → 3w, Runs, Inn
      case 5:
        final sorted = [...bowlingStats]
          ..sort((a, b) => b.threeWickets.compareTo(a.threeWickets));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: ['${p.threeWickets}', '${p.runs}', '${p.matches}'],
          );
        });
        break;

      // 6️⃣ Most 5w → 5w, Runs, Inn
      case 6:
        final sorted = [...bowlingStats]
          ..sort((a, b) => b.fiveWickets.compareTo(a.fiveWickets));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: ['${p.fiveWickets}', '${p.runs}', '${p.matches}'],
          );
        });
        break;

      // 7️⃣ Dots → Dots, Balls, Runs
      // assuming dots = total balls - (balls for runs scored)
      // if no direct dots field exists, we’ll estimate
      case 7:
        final sorted = [...bowlingStats]
          ..sort((a, b) => a.economy.compareTo(b.economy));
        data = List.generate(sorted.length, (i) {
          final p = sorted[i];
          final balls = (p.overs * 6).round();
          // you can replace this with actual p.dots if available
          final estimatedDots = (balls - (p.runs / 1.5))
              .clamp(0, balls)
              .round();
          return LeaderboardRowData(
            rank: i + 1,
            playerName: p.playerName,
            stats: ['$estimatedDots', '$balls', '${p.runs}'],
          );
        });
        break;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = cubit.state;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileTabBar(
            onTap: (index) => cubit.changeStatsTabTable(index),
            mainTabs: const [
              "Wickets",
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IndexedStack(
                index: state.selectedStatsTabTableType,
                children: List.generate(8, (index) {
                  final data = generateLeaderboardData(context, index);
                  final headings = [
                    ["Wkt", "Mtchs", "Avg"],
                    ["Avg", "Mtchs", "Wkt"],
                    ["Eco", "Bal", "Runs"],
                    ["Mai", "Balls", "Runs"],
                    ["Balls", "Mtchs", "Eco"],
                    ["3w", "Runs", "Mtchs"],
                    ["5w", "Runs", "Mtchs"],
                    ["Dots", "Balls", "Runs"],
                  ][index];

                  return data.isEmpty
                      ? Center(
                          child: Text(
                            "No Data",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                            ),
                          ),
                        )
                      : LeaderboardTable(
                          headings: headings,
                          data: data,
                          loading: state.loading,
                        );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
