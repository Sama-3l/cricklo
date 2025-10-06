import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class StatsTable extends StatelessWidget {
  const StatsTable({
    super.key,
    required this.stats,
    this.horizontalLine = false,
    this.verticalLine = true,
  });

  final Map<String, List<String>> stats;
  final bool horizontalLine;
  final bool verticalLine;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: screenWidth),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(), // first column takes remaining width
          1: IntrinsicColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        },

        border: TableBorder(
          horizontalInside: horizontalLine
              ? BorderSide(color: ColorsConstants.onSurfaceGrey, width: 0.5)
              : BorderSide.none,
          top: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
          verticalInside: verticalLine
              ? BorderSide(color: ColorsConstants.onSurfaceGrey, width: 0.5)
              : BorderSide.none,
        ),
        children: [
          // Header row
          TableRow(
            // decoration: const BoxDecoration(color: Colors.grey),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '',
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'T10',
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.accentOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'T20',
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.accentOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ODI',
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.accentOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          // Data rows
          ...stats.entries.map(
            (entry) => TableRow(
              children: [
                // first column left-aligned, larger width
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.key,
                      textAlign: TextAlign.left,
                      style: TextStyles.poppinsSemiBold.copyWith(
                        letterSpacing: -0.5,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                // rest columns centered
                for (final value in entry.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12,
                    ),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 10,
                        letterSpacing: -0.2,
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
