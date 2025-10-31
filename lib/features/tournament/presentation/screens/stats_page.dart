import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_highligh_stat_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/screens/tournament_overall_stats_page.dart';
import 'package:cricklo/features/tournament/presentation/screens/tournament_bat_stats_screen.dart';
import 'package:cricklo/features/tournament/presentation/screens/tournament_bowl_stats_screen.dart';
import 'package:cricklo/features/tournament/presentation/screens/tournament_field_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key, required this.stats});

  final List<TournamentHighlightStat> stats;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    Widget buildTabContent(int index) {
      switch (index) {
        case 0:
          return OverallStatsPage(
            tournamentEntity: state.tournamentEntity!,
            stats: stats,
          );
        case 1:
          return TournamentBatStatsScreen();
        case 2:
          return TournamentBowlStatsScreen();
        case 3:
          return TournamentFieldStatsScreen();
        default:
          return SizedBox.shrink();
      }
    }

    return Column(
      children: [
        // Sub tabs
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: StatsTableFilterTabBar(
            selectedTab: state.selectedStatsTab,
            selectTab: (index) => cubit.changeStatsTab(index),
            options: ["Overall", "Bat", "Bowl", "Field"],
          ),
        ),

        // Tab content
        Expanded(child: buildTabContent(state.selectedStatsTab)),
      ],
    );
  }
}
