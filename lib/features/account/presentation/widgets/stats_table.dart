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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // vertical scroll
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // horizontal scroll
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(), // first column takes remaining width
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
              3: IntrinsicColumnWidth(),
              4: IntrinsicColumnWidth(),
              5: IntrinsicColumnWidth(),
            },
            border: TableBorder(
              horizontalInside: horizontalLine
                  ? BorderSide(
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      width: 0.5,
                    )
                  : BorderSide.none,
              verticalInside: verticalLine
                  ? BorderSide(color: ColorsConstants.defaultBlack, width: 0.5)
                  : BorderSide.none,
            ),
            children: [
              // Header row
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                      ),
                    ),
                  ),
                  for (final format in ['T10', 'T20', 'T30', 'ODI', 'Test'])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        format,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        entry.key,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          letterSpacing: -0.5,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    for (final value in entry.value)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12,
                        ),
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                          style: TextStyles.poppinsMedium.copyWith(
                            fontSize: 12,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
