import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class OverallScreen extends StatelessWidget {
  const OverallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Overall Stats',
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 20,
                letterSpacing: -1.2,
                color: ColorsConstants.defaultBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(), // first column takes remaining width
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },

            border: TableBorder(
              borderRadius: BorderRadius.circular(8),
              horizontalInside: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
              top: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              bottom: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
              left: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              right: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              verticalInside: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: ColorsConstants.accentOrange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Matches',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Won',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Win%',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              TableRow(
                // decoration: const BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(), // first column takes remaining width
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
              },

              border: TableBorder(
                borderRadius: BorderRadius.circular(8),
                horizontalInside: BorderSide(
                  color: ColorsConstants.onSurfaceGrey,
                  width: 1,
                ),
                top: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
                bottom: BorderSide(
                  color: ColorsConstants.onSurfaceGrey,
                  width: 1,
                ),
                left: BorderSide(
                  color: ColorsConstants.onSurfaceGrey,
                  width: 1,
                ),
                right: BorderSide(
                  color: ColorsConstants.onSurfaceGrey,
                  width: 1,
                ),
                verticalInside: BorderSide(
                  color: ColorsConstants.onSurfaceGrey,
                  width: 1,
                ),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: ColorsConstants.accentOrange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lost',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tie',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Draw',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'NR',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  // decoration: const BoxDecoration(color: Colors.grey),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '0',
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '0',
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '0',
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '0',
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              'Team Scores',
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 20,
                letterSpacing: -1.2,
                color: ColorsConstants.defaultBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(), // first column takes remaining width
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
            },

            border: TableBorder(
              borderRadius: BorderRadius.circular(8),
              horizontalInside: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
              top: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              bottom: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
              left: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              right: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              verticalInside: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: ColorsConstants.accentOrange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'High',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'Low',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              TableRow(
                // decoration: const BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Scored',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              TableRow(
                // decoration: const BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Conceded',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              'Toss',
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 20,
                letterSpacing: -1.2,
                color: ColorsConstants.defaultBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(), // first column takes remaining width
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },

            border: TableBorder(
              borderRadius: BorderRadius.circular(8),
              horizontalInside: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
              top: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              bottom: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
              left: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              right: BorderSide(color: ColorsConstants.onSurfaceGrey, width: 1),
              verticalInside: BorderSide(
                color: ColorsConstants.onSurfaceGrey,
                width: 1,
              ),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: ColorsConstants.accentOrange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Toss Won',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'Bat First',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'Bowl First',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              TableRow(
                // decoration: const BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 8,
                    ),
                    child: Text(
                      '0',
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
