import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_stats/chased_defended_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_stats/overall_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_stats/partnerships_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamStatsScreens extends StatelessWidget {
  const TeamStatsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeamPageCubit>();
    final state = cubit.state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
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
                PartnershipsScreen(),
                ChasedDefendedScreen(),
                ChasedDefendedScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
