import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:cricklo/core/utils/constants/theme.dart';

class ShimmerTournamentTile extends StatelessWidget {
  const ShimmerTournamentTile({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8, right: 16),
      child: Shimmer(
        child: Container(
          width: width,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner placeholder
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),

              // Padding for text section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column: tournament title + date range
                    Expanded(
                      child: Container(
                        width: width * 0.6,
                        height: 20,
                        decoration: BoxDecoration(
                          color: ColorsConstants.textBlack.withValues(
                            alpha: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: ColorsConstants.textBlack.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            color: ColorsConstants.textBlack.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  bottom: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.4,
                      height: 12,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    const Spacer(),

                    Container(
                      width: width * 0.2,
                      height: 24,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
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
