import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/leaderboard_row_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LeaderboardTable extends StatelessWidget {
  const LeaderboardTable({
    super.key,
    required this.headings,
    required this.data,
    this.team,
    required this.loading,
  });

  final List<String> headings;
  final List<LeaderboardRowData> data;
  final String? team;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: loading
          ? _buildShimmerTable(context)
          : ListView(
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: IntrinsicColumnWidth(),
                    3: IntrinsicColumnWidth(),
                  },
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      width: 0.5,
                    ),
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                    verticalInside: BorderSide.none,
                  ),
                  children: [
                    // 🟧 Header row
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            '',
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        ...headings.map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              e,
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.accentOrange,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 🟩 Dynamic player rows
                    ...data.map(
                      (row) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: ColorsConstants.accentOrange,
                                  child: Text(
                                    '${row.rank}',
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 10,
                                      letterSpacing: -0.2,
                                      color: ColorsConstants.defaultWhite,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        row.playerName,
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 16,
                                              letterSpacing: -0.8,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      if (team != null || row.teamName != null)
                                        Text(
                                          row.teamName ?? team!,
                                          style: TextStyles.poppinsMedium
                                              .copyWith(
                                                fontSize: 12,
                                                letterSpacing: -0.5,
                                                color: ColorsConstants
                                                    .defaultBlack
                                                    .withValues(alpha: 0.5),
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...row.stats.map(
                            (stat) => Center(
                              child: Text(
                                stat,
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                ),
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

  /// 🩶 Shimmer loading placeholder
  Widget _buildShimmerTable(BuildContext context) {
    return Shimmer(
      child: ListView(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(),
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
              3: IntrinsicColumnWidth(),
            },
            children: [
              // Header shimmer row
              TableRow(
                children: [
                  const SizedBox(height: 32),
                  ...List.generate(
                    headings.length,
                    (_) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 8.0,
                      ),
                      child: Container(
                        height: 16,
                        width: 60,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Shimmer rows for leaderboard
              ...List.generate(6, (index) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 16,
                                  width: 100,
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.5),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 12,
                                  width: 60,
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(
                      headings.length,
                      (_) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 16,
                          width: 40,
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
