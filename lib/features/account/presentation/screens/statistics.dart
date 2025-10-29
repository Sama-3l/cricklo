import 'package:cricklo/features/account/domain/entities/batting_stats_entity.dart';
import 'package:cricklo/features/account/domain/entities/bowling_stats_entity.dart';
import 'package:cricklo/features/account/domain/entities/fielding_stats_entity.dart';
import 'package:cricklo/features/account/presentation/screens/match_wise_stats_page.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
// import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    super.key,
    required this.userEntity,
    required this.selectedStatisticsTab,
    required this.changeStatisticsTab,
  });

  final UserEntity userEntity;

  final int selectedStatisticsTab;
  final Function(int index) changeStatisticsTab;

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<AccountCubit>();
    // final state = context.read<AccountCubit>().state;
    final formats = ['T10', 'T20', 'T30', 'ODI', 'Test'];

    /// Helper function to get batting stats safely
    String getBatting(
      String format,
      num? Function(BattingStatsEntity s) getter,
    ) {
      final stat = userEntity.accountStats?.batting.firstWhere(
        (s) => s.format == format,
        orElse: () => BattingStatsEntity(
          format: format,
          matches: 0,
          innings: 0,
          runs: 0,
          balls: 0,
          highest: 0,
          average: 0,
          strikeRate: 0,
          notOuts: 0,
          ducks: 0,
          hundreds: 0,
          fifties: 0,
          thirties: 0,
          sixes: 0,
          fours: 0,
          dots: 0,
        ),
      );
      return getter(stat!).toString();
    }

    /// Helper for bowling
    String getBowling(
      String format,
      num? Function(BowlingStatsEntity s) getter,
    ) {
      final stat = userEntity.accountStats?.bowling.firstWhere(
        (s) => s.format == format,
        orElse: () => BowlingStatsEntity(
          format: format,
          matches: 0,
          innings: 0,
          overs: 0,
          runs: 0,
          maidens: 0,
          average: 0,
          economy: 0,
          strikeRate: 0,
          threeWickets: 0,
          fiveWickets: 0,
          dots: 0,
          wickets: 0,
        ),
      );
      return getter(stat!).toString();
    }

    /// Helper for fielding
    String getFielding(
      String format,
      num? Function(FieldingStatsEntity s) getter,
    ) {
      final stat = userEntity.accountStats?.fielding.firstWhere(
        (s) => s.format == format,
        orElse: () => FieldingStatsEntity(
          format: format,
          catches: 0,
          stumpings: 0,
          runOuts: 0,
        ),
      );
      return getter(stat!).toString();
    }

    /// 🏏 Batting Table Data
    final battingStats = {
      'Matches': [for (final f in formats) getBatting(f, (s) => s.matches)],
      'Innings': [for (final f in formats) getBatting(f, (s) => s.innings)],
      'Runs': [for (final f in formats) getBatting(f, (s) => s.runs)],
      'Balls': [for (final f in formats) getBatting(f, (s) => s.balls)],
      'Highest': [for (final f in formats) getBatting(f, (s) => s.highest)],
      'Average': [for (final f in formats) getBatting(f, (s) => s.average)],
      'SR': [for (final f in formats) getBatting(f, (s) => s.strikeRate)],
      'Not-Out': [for (final f in formats) getBatting(f, (s) => s.notOuts)],
      'Ducks': [for (final f in formats) getBatting(f, (s) => s.ducks)],
      '100s': [for (final f in formats) getBatting(f, (s) => s.hundreds)],
      '50s': [for (final f in formats) getBatting(f, (s) => s.fifties)],
      '30s': [for (final f in formats) getBatting(f, (s) => s.thirties)],
    };

    /// 🎯 Bowling Table Data
    final bowlingStats = {
      'Matches': [for (final f in formats) getBowling(f, (s) => s.matches)],
      'Innings': [for (final f in formats) getBowling(f, (s) => s.innings)],
      'Overs': [for (final f in formats) getBowling(f, (s) => s.overs)],
      'Runs': [for (final f in formats) getBowling(f, (s) => s.runs)],
      'Dots': [for (final f in formats) getBowling(f, (s) => s.dots)],
      'Maidens': [for (final f in formats) getBowling(f, (s) => s.maidens)],
      'Average': [for (final f in formats) getBowling(f, (s) => s.average)],
      'Economy': [for (final f in formats) getBowling(f, (s) => s.economy)],
      '5w': [for (final f in formats) getBowling(f, (s) => s.fiveWickets)],
      '3w': [for (final f in formats) getBowling(f, (s) => s.threeWickets)],
    };

    /// 🧤 Fielding Table Data
    final fieldingStats = {
      'Catches': [for (final f in formats) getFielding(f, (s) => s.catches)],
      'Stumping': [for (final f in formats) getFielding(f, (s) => s.stumpings)],
      'Runout': [for (final f in formats) getFielding(f, (s) => s.runOuts)],
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
      child: Column(
        children: [
          // Sub tabs
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: StatsTableFilterTabBar(
              selectedTab: selectedStatisticsTab,
              selectTab: (index) => changeStatisticsTab(index),
              options: ["Bat", "Bowl", "Field", "Match-wise"],
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: selectedStatisticsTab,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ).copyWith(top: 8),
                  child: StatsTable(
                    horizontalLine: true,
                    verticalLine: false,
                    stats: battingStats,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ).copyWith(top: 8),
                  child: StatsTable(
                    horizontalLine: true,
                    verticalLine: false,
                    stats: bowlingStats,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ).copyWith(top: 8),
                  child: StatsTable(
                    horizontalLine: true,
                    verticalLine: false,
                    stats: fieldingStats,
                  ),
                ),
                MatchWiseStatsPage(matchwiseStats: userEntity.matchwiseStats),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
