import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class YearlyReview extends StatefulWidget {
  const YearlyReview({super.key});

  @override
  State<YearlyReview> createState() => _YearlyReviewState();
}

class _YearlyReviewState extends State<YearlyReview> {
  bool isBatting = true;

  @override
  Widget build(BuildContext context) {
    final battingStats = {
      'This year so far': ['0', '0', '0'],
      'Last year': ['0', '0', '0'],
    };

    final bowlingStats = {
      'This year so far': ['0', '0', '0'],
      'Last year': ['0', '0', '0'],
    };

    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
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
                color: ColorsConstants.onSurfaceGrey,
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
