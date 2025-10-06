import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/stat_tab.dart';
import 'package:flutter/material.dart';

class StatsTableFilterTabBar extends StatelessWidget {
  const StatsTableFilterTabBar({
    super.key,
    required this.options,
    required this.selectTab,
    required this.selectedTab,
  });

  final List<String> options;
  final Function(int) selectTab;
  final int selectedTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsConstants.accentOrange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...[
            for (int i = 0; i < options.length; i++) ...[
              StatTab(
                lastIndex: options.length - 1,
                label: options[i],
                selected: selectedTab == i,
                index: i,
                onStatOptionTap: selectTab,
              ),
              if (i != options.length - 1)
                Container(
                  color: ColorsConstants.accentOrange,
                  width: selectedTab == i || selectedTab == i + 1 ? 0 : 0.5,
                  height: 16,
                ),
            ],
          ],
          // StatTab(
          //   label: 'Bat',
          //   selected: state.selectedStatisticsTab == 0,
          //   index: 0,
          // ),
          // Container(
          //   color: ColorsConstants.accentOrange,
          //   width:
          //       state.selectedStatisticsTab == 0 ||
          //           state.selectedStatisticsTab == 1
          //       ? 0
          //       : 0.5,
          //   height: 16,
          // ),
          // StatTab(
          //   label: 'Bowl',
          //   selected: state.selectedStatisticsTab == 1,
          //   index: 1,
          // ),
          // Container(
          //   color: ColorsConstants.accentOrange,
          //   width:
          //       state.selectedStatisticsTab == 1 ||
          //           state.selectedStatisticsTab == 2
          //       ? 0
          //       : 0.5,
          //   height: 16,
          // ),
          // StatTab(
          //   label: 'Field',
          //   selected: state.selectedStatisticsTab == 2,
          //   index: 2,
          // ),
          // Container(
          //   color: ColorsConstants.accentOrange,
          //   width:
          //       state.selectedStatisticsTab == 2 ||
          //           state.selectedStatisticsTab == 3
          //       ? 0
          //       : 0.5,
          //   height: 16,
          // ),
          // StatTab(
          //   label: 'Match-wise',
          //   selected: state.selectedStatisticsTab == 3,
          //   index: 3,
          // ),
        ],
      ),
    );
  }
}
