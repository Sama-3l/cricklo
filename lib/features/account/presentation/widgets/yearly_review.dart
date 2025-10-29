import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/domain/entities/matchwise_stats_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:flutter/material.dart';

class YearlyReview extends StatefulWidget {
  const YearlyReview({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  State<YearlyReview> createState() => _YearlyReviewState();
}

class _YearlyReviewState extends State<YearlyReview> {
  bool isBatting = true;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentYear = now.year;
    final lastYear = currentYear - 1;

    final List<MatchWiseStatsEntity> matches = widget.userEntity.matchwiseStats;

    // Helper to filter matches by year
    List<MatchWiseStatsEntity> getMatchesByYear(int year) =>
        matches.where((m) => m.date.year == year).toList();

    final thisYearMatches = getMatchesByYear(currentYear);
    final lastYearMatches = getMatchesByYear(lastYear);

    // --- Batting helpers ---
    int sumRuns(List<MatchWiseStatsEntity> matches) =>
        matches.fold(0, (sum, m) => sum + (m.runs ?? 0));

    double average(List<MatchWiseStatsEntity> matches) {
      final innings = matches.where((m) => (m.runs ?? 0) > 0).length;
      if (innings == 0) return 0;
      return sumRuns(matches) / innings;
    }

    int highScore(List<MatchWiseStatsEntity> matches) =>
        matches.fold(0, (max, m) => (m.runs ?? 0) > max ? (m.runs ?? 0) : max);

    // --- Bowling helpers ---
    double sumOvers(List<MatchWiseStatsEntity> matches) {
      int totalBalls = 0;

      for (final m in matches) {
        final overs = m.overs ?? 0.0;
        final wholeOvers = overs.floor();
        final balls = ((overs - wholeOvers) * 10)
            .round(); // e.g. 3.5 => 3 + 5 balls
        totalBalls += (wholeOvers * 6 + balls);
      }

      final completeOvers = totalBalls ~/ 6;
      final remainingBalls = totalBalls % 6;

      // return in cricket format, e.g. 4.2 (4 overs, 2 balls)
      return double.parse('$completeOvers.${remainingBalls}');
    }

    int sumWickets(List<MatchWiseStatsEntity> matches) =>
        matches.fold(0, (sum, m) => sum + (m.wickets ?? 0));

    double economy(List<MatchWiseStatsEntity> matches) {
      final totalOvers = sumOvers(matches);
      if (totalOvers == 0) return 0;
      final totalRuns = matches.fold(0, (sum, m) => sum + (m.bowlingRuns ?? 0));
      return totalRuns / totalOvers;
    }

    final battingStats = {
      'This year so far': [
        sumRuns(thisYearMatches).toString(),
        average(thisYearMatches).toStringAsFixed(1),
        highScore(thisYearMatches).toString(),
      ],
      'Last year': [
        sumRuns(lastYearMatches).toString(),
        average(lastYearMatches).toStringAsFixed(1),
        highScore(lastYearMatches).toString(),
      ],
    };

    final bowlingStats = {
      'This year so far': [
        sumOvers(thisYearMatches).toStringAsFixed(1),
        sumWickets(thisYearMatches).toString(),
        economy(thisYearMatches).toStringAsFixed(1),
      ],
      'Last year': [
        sumOvers(lastYearMatches).toStringAsFixed(1),
        sumWickets(lastYearMatches).toString(),
        economy(lastYearMatches).toStringAsFixed(1),
      ],
    };

    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorsConstants.onSurfaceGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Toggle
          Container(
            decoration: BoxDecoration(
              color: ColorsConstants.defaultWhite,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: isBatting
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin: const EdgeInsets.all(4),
                    height: 32,
                    decoration: BoxDecoration(
                      color: ColorsConstants.accentOrange,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: () => setState(() => isBatting = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Batting",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              color: isBatting
                                  ? ColorsConstants.defaultWhite
                                  : ColorsConstants.defaultBlack,
                              fontSize: 12,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: () => setState(() => isBatting = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            "Bowling",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              color: !isBatting
                                  ? ColorsConstants.defaultWhite
                                  : ColorsConstants.defaultBlack,
                              fontSize: 12,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Table
          Table(
            border: TableBorder(
              horizontalInside: BorderSide.none,
              top: BorderSide.none,
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
              verticalInside: BorderSide(
                color: ColorsConstants.defaultBlack,
                width: 0.5,
              ),
            ),
            columnWidths: const {
              0: FlexColumnWidth(2), // row title
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              // Header
              TableRow(
                children: [
                  const SizedBox(), // empty top-left
                  for (final head
                      in isBatting
                          ? ['Runs', 'Avg', 'HS']
                          : ['Overs', 'Wkts', 'Eco'])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        head,
                        textAlign: TextAlign.center,
                        style: TextStyles.poppinsBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.accentOrange,
                        ),
                      ),
                    ),
                ],
              ),
              // Data rows
              ...(isBatting ? battingStats : bowlingStats).entries.map(
                (entry) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        entry.key,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          letterSpacing: -0.5,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    for (final val in entry.value)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          val,
                          textAlign: TextAlign.center,
                          style: TextStyles.poppinsMedium.copyWith(
                            letterSpacing: -0.5,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
