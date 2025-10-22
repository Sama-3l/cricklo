import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class OverallStatsPage extends StatelessWidget {
  const OverallStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          childAspectRatio: 0.8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsConstants.onSurfaceGrey,
              boxShadow: [
                BoxShadow(
                  color: ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: ColorsConstants.surfaceOrange,
                  child: Icon(Icons.people, size: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  "75",
                  style: TextStyles.poppinsBold.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 24,
                    letterSpacing: -1.2,
                  ),
                ),
                Text(
                  "Most Runs",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 12,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Aryan Vaish",
                  style: TextStyles.poppinsBold.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                ),
                Text(
                  "Aviral All Stars".toUpperCase(),
                  style: TextStyles.poppinsSemiBold.copyWith(
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                    fontSize: 12,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
