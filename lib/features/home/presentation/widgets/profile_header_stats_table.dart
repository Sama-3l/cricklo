import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class ProfileHeaderStatsTable extends StatelessWidget {
  const ProfileHeaderStatsTable({
    super.key,
    required this.heading,
    required this.stats,
  });

  final List<String> heading;
  final List<double> stats;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        border: TableBorder.all(
          borderRadius: BorderRadius.circular(8),
          color: ColorsConstants.defaultBlack,
        ),

        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          // Header row
          TableRow(
            decoration: BoxDecoration(
              color: ColorsConstants.accentOrange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            children: heading
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      e,
                      textAlign: TextAlign.center,
                      style: TextStyles.poppinsSemiBold.copyWith(
                        color: ColorsConstants.defaultWhite,
                        fontSize: 12,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          // Data rows
          TableRow(
            children: stats
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      e.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyles.poppinsSemiBold.copyWith(
                        color: ColorsConstants.defaultBlack,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
