import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class PointsTable extends StatelessWidget {
  const PointsTable({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> headings = ["M", "W", "L", "P", "NRR"];
    return Table(
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
        // Header row
        TableRow(
          // decoration: const BoxDecoration(color: Colors.grey),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Teams',
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.accentOrange,
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
        TableRow(
          // decoration: const BoxDecoration(color: Colors.grey),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: ColorsConstants.surfaceOrange,
                    child: Icon(
                      Icons.people,
                      size: 12,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Aaryan Ji',
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
            ),
            ...headings.map(
              (e) => Center(
                child: Text(
                  '0',
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          // decoration: const BoxDecoration(color: Colors.grey),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: ColorsConstants.surfaceOrange,
                    child: Icon(
                      Icons.people,
                      size: 12,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Aaryan Ji',
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
            ),
            ...headings.map(
              (e) => Center(
                child: Text(
                  '0',
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          // decoration: const BoxDecoration(color: Colors.grey),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: ColorsConstants.surfaceOrange,
                    child: Icon(
                      Icons.people,
                      size: 12,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Aaryan Ji',
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
            ),
            ...headings.map(
              (e) => Center(
                child: Text(
                  '0',
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          // decoration: const BoxDecoration(color: Colors.grey),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: ColorsConstants.surfaceOrange,
                    child: Icon(
                      Icons.people,
                      size: 12,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Aaryan Ji',
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
            ),
            ...headings.map(
              (e) => Center(
                child: Text(
                  '0',
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
