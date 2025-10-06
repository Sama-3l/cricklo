import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/bat_stats_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/bowl_stats_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/field_stats_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/mvp_stats_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_stats/team_stats_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamProfileStatistics extends StatelessWidget {
  const TeamProfileStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    final state = cubit.state;

    Widget buildTabContent(int index) {
      switch (index) {
        case 0:
          return TeamStatsScreens();
        case 1:
          return BatStatsScreen();
        case 2:
          return BowlStatsScreen();
        case 3:
          return FieldStatsScreen();
        case 4:
          return MvpStatsScreen();
        default:
          return SizedBox.shrink();
      }
    }

    return Column(
      children: [
        // Sub tabs
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 24),
          child: StatsTableFilterTabBar(
            selectedTab: state.selectedStatsTab,
            selectTab: (index) => cubit.changeStatsTab(index),
            options: ["Team", "Bat", "Bowl", "Field", "MVP"],
          ),
        ),

        // Tab content
        Expanded(child: buildTabContent(state.selectedStatsTab)),
      ],
    );
  }
}
