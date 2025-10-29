import 'package:cricklo/features/teams/domain/entities/partnership_stats_entity.dart';
import 'package:cricklo/features/teams/presentation/widgets/partnership_stat.dart';
import 'package:flutter/material.dart';

class PartnershipsScreen extends StatelessWidget {
  const PartnershipsScreen({super.key, required this.partnerships});

  final List<PartnershipStatsEntity> partnerships;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: partnerships.length,
        itemBuilder: (context, index) =>
            PartnershipStat(partnership: partnerships[index]),
      ),
    );
  }
}
