import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentFormStats extends StatelessWidget {
  const RecentFormStats({super.key, required this.title, required this.stats});

  final String title;
  final List<String> stats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: ColorsConstants.accentOrange,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                title,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ...stats.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: ColorsConstants.surfaceOrange,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    e,
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
