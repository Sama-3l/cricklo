import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class LeaderboardTable extends StatelessWidget {
  const LeaderboardTable({super.key, required this.headings});

  final List<String> headings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(), // first column takes remaining width
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
          // Header row
          TableRow(
            // decoration: const BoxDecoration(color: Colors.grey),
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
          TableRow(
            // decoration: const BoxDecoration(color: Colors.grey),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: ColorsConstants.accentOrange,
                      child: Text(
                        '1',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 10,
                          letterSpacing: -0.2,
                          color: ColorsConstants.defaultWhite,
                        ),
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
                      backgroundColor: ColorsConstants.accentOrange,
                      child: Text(
                        '2',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 10,
                          letterSpacing: -0.2,
                          color: ColorsConstants.defaultWhite,
                        ),
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
                      backgroundColor: ColorsConstants.accentOrange,
                      child: Text(
                        '3',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 10,
                          letterSpacing: -0.2,
                          color: ColorsConstants.defaultWhite,
                        ),
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
                      backgroundColor: ColorsConstants.accentOrange,
                      child: Text(
                        '4',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 10,
                          letterSpacing: -0.2,
                          color: ColorsConstants.defaultWhite,
                        ),
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
      ),
    );
  }
}
