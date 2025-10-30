import 'package:cricklo/features/teams/domain/entities/leaderboard_row_data_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldStatsScreen extends StatelessWidget {
  const FieldStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    final state = cubit.state;
    final team = cubit.state.team!;

    // Sort players by catches (descending)
    final sorted = [...team.fieldingStats]
      ..sort((a, b) => b.catches.compareTo(a.catches));
    int p = 1;

    final rows = sorted.map((stat) {
      return LeaderboardRowData(
        playerName: stat.player.name,
        stats: [
          stat.catches.toString(), // Catch
          stat.runouts.toString(), // RunOut
          stat.stumpings.toString(), // Stump
        ],
        rank: p++,
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: LeaderboardTable(
        headings: ["Catch", "RunOut", "Stump"],
        data: rows,
        loading: state.loading,
      ),
    );
  }
}
