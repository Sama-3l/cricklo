import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class MvpStatsScreen extends StatelessWidget {
  const MvpStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Padding(
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
              color: ColorsConstants.onSurfaceGrey,
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
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.07,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'MVP Rules',
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 12,
                                letterSpacing: -0.5,
                                color: ColorsConstants.accentOrange,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: ColorsConstants.accentOrange,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Pts.",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.accentOrange,
                    ),
                    textAlign: TextAlign.left,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aaryan Ji',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          Text(
                            'Bat 0, Bowl 0, Field 0',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.2,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    '0',
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                    textAlign: TextAlign.left,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aaryan Ji',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          Text(
                            'Bat 0, Bowl 0, Field 0',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.2,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    '0',
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                    textAlign: TextAlign.left,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aaryan Ji',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          Text(
                            'Bat 0, Bowl 0, Field 0',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.2,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    '0',
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                    textAlign: TextAlign.left,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aaryan Ji',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          Text(
                            'Bat 0, Bowl 0, Field 0',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 10,
                              letterSpacing: -0.2,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    '0',
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
