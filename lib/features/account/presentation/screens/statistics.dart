import 'package:cricklo/features/account/presentation/blocs/cubits/AccountPageCubit/account_page_cubit.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table.dart';
// import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountCubit>();
    final state = context.read<AccountCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
      child: Column(
        children: [
          // Sub tabs
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: StatsTableFilterTabBar(
              selectedTab: state.selectedStatisticsTab,
              selectTab: (index) => cubit.changeStatisticsTab(index),
              options: ["Bat", "Bowl", "Field", "Match-wise"],
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
                    horizontalLine: true,
                    verticalLine: false,
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
                    horizontalLine: true,
                    verticalLine: false,
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
                    horizontalLine: true,
                    verticalLine: false,
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
