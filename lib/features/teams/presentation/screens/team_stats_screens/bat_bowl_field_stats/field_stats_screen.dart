import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/bat_bowl_field_stats/leaderboard_table.dart';
import 'package:flutter/material.dart';

class FieldStatsScreen extends StatelessWidget {
  const FieldStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: LeaderboardTable(headings: ["Catch", "RunOu", "Stump"]),
    );
  }
}
