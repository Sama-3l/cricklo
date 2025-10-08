import 'package:cricklo/core/utils/constants/dummy_data.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:flutter/material.dart';

class ChasedDefendedScreen extends StatelessWidget {
  const ChasedDefendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // height: 200,
            margin: EdgeInsets.only(top: 12),
            // padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
            ),
            child: MatchTile(matchEntity: dummyMatchScheduled, live: false),
          ),
          Container(
            // height: 200,
            margin: EdgeInsets.symmetric(vertical: 8),
            // padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
            ),
            child: MatchTile(matchEntity: dummyMatchScheduled, live: false),
          ),
          Container(
            // height: 200,
            // padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
            ),
            child: MatchTile(matchEntity: dummyMatchScheduled, live: false),
          ),
        ],
      ),
    );
  }
}
