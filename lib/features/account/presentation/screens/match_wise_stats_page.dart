import 'package:cricklo/features/account/domain/entities/matchwise_stats_entity.dart';
import 'package:cricklo/features/account/presentation/widgets/match_stats_tile.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';

class MatchWiseStatsPage extends StatelessWidget {
  const MatchWiseStatsPage({super.key, required this.matchwiseStats});

  final List<MatchWiseStatsEntity> matchwiseStats;

  @override
  Widget build(BuildContext context) {
    matchwiseStats.sort(
      (a, b) =>
          DateTime(
            b.date.year,
            b.date.month,
            b.date.day,
            b.time.hour,
            b.time.minute,
          ).compareTo(
            DateTime(
              a.date.year,
              a.date.month,
              a.date.day,
              a.time.hour,
              a.time.minute,
            ),
          ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          SectionHeader(title: "Match-wise Stats", showIcon: false),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: matchwiseStats.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  bottom: index == matchwiseStats.length - 1 ? 24 : 0,
                ),
                child: MatchStatsTile(match: matchwiseStats[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
