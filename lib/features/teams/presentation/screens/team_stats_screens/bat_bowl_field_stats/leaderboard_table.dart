import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/leaderboard_row_data_entity.dart';
import 'package:flutter/material.dart';

class LeaderboardTable extends StatelessWidget {
  const LeaderboardTable({
    super.key,
    required this.headings,
    required this.data,
    this.team,
  });

  final List<String> headings;
  final List<LeaderboardRowData> data;
  final String? team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(),
          1: IntrinsicColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        },
        border: TableBorder(
          horizontalInside: BorderSide(
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row.playerName,
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          if (team != null || row.teamName != null)
                            Text(
                              row.teamName ?? team!,
                              style: TextStyles.poppinsMedium.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                                color: ColorsConstants.defaultBlack.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                        ],
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
    );
  }
}
