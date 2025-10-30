import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerMatchTile extends StatelessWidget {
  const ShimmerMatchTile({super.key, this.removePadding = false});

  final bool removePadding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;

    return Padding(
      padding: EdgeInsets.only(
        left: removePadding ? 0 : 16.0,
        top: 8,
        right: removePadding ? 0 : 16.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Shimmer(
          color: ColorsConstants.defaultBlack,
          child: Container(
            width: width,
            height: 181,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorsConstants.defaultWhite,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ColorsConstants.textBlack.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: width * 0.4,
                          height: 12,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: width * 0.3,
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

                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),

                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Container(
                      height: 14,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Spacer(),

                    Container(
                      width: 24,
                      height: 14,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),

                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Container(
                      height: 14,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Spacer(),

                    Container(
                      width: 24,
                      height: 14,
                      decoration: BoxDecoration(
                        color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                Container(
                  width: width * 0.6,
                  height: 10,
                  decoration: BoxDecoration(
                    color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
