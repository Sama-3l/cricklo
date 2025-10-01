import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/cubit/account_page_cubit.dart';
import 'package:cricklo/features/account/presentation/widgets/stat_tab.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AccountCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
      child: Column(
        children: [
          // Sub tabs
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorsConstants.accentOrange),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatTab(
                  label: 'Bat',
                  selected: state.selectedStatisticsTab == 0,
                  index: 0,
                ),
                Container(
                  color: ColorsConstants.accentOrange,
                  width:
                      state.selectedStatisticsTab == 0 ||
                          state.selectedStatisticsTab == 1
                      ? 0
                      : 0.5,
                  height: 16,
                ),
                StatTab(
                  label: 'Bowl',
                  selected: state.selectedStatisticsTab == 1,
                  index: 1,
                ),
                Container(
                  color: ColorsConstants.accentOrange,
                  width:
                      state.selectedStatisticsTab == 1 ||
                          state.selectedStatisticsTab == 2
                      ? 0
                      : 0.5,
                  height: 16,
                ),
                StatTab(
                  label: 'Field',
                  selected: state.selectedStatisticsTab == 2,
                  index: 2,
                ),
                Container(
                  color: ColorsConstants.accentOrange,
                  width:
                      state.selectedStatisticsTab == 2 ||
                          state.selectedStatisticsTab == 3
                      ? 0
                      : 0.5,
                  height: 16,
                ),
                StatTab(
                  label: 'Match-wise',
                  selected: state.selectedStatisticsTab == 3,
                  index: 3,
                ),
              ],
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: state.selectedStatisticsTab,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ).copyWith(top: 8),
                  child: StatsTable(
                    stats: {
                      'Matches': ['0', '0', '0'],
                      'Innings': ['0', '0', '0'],
                      'Runs': ['0', '0', '0'],
                      'Balls': ['0', '0', '0'],
                      'Highest': ['0', '0', '0'],
                      'Average': ['0', '0', '0'],
                      'SR': ['0', '0', '0'],
                      'Not-Out': ['0', '0', '0'],
                      'Ducks': ['0', '0', '0'],
                      '100s': ['0', '0', '0'],
                      '50s': ['0', '0', '0'],
                      '30s': ['0', '0', '0'],
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ).copyWith(top: 8),
                  child: StatsTable(
                    stats: {
                      'Matches': ['0', '0', '0'],
                      'Innings': ['0', '0', '0'],
                      'Overs': ['0', '0', '0'],
                      'Runs': ['0', '0', '0'],
                      'Dots': ['0', '0', '0'],
                      'Maidens': ['0', '0', '0'],
                      'Average': ['0', '0', '0'],
                      'Economy': ['0', '0', '0'],
                      'Best': ['0', '0', '0'],
                      'SR': ['0', '0', '0'],
                      '5w': ['0', '0', '0'],
                      '3w': ['0', '0', '0'],
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ).copyWith(top: 8),
                  child: StatsTable(
                    stats: {
                      'Catches': ['0', '0', '0'],
                      'Stumping': ['0', '0', '0'],
                      'Runout': ['0', '0', '0'],
                    },
                  ),
                ),
                Center(child: Text("Match-wise Stats")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
