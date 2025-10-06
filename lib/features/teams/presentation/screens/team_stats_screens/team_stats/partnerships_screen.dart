import 'package:cricklo/features/teams/presentation/widgets/partnership_stat.dart';
import 'package:flutter/material.dart';

class PartnershipsScreen extends StatelessWidget {
  const PartnershipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: PartnershipStat(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: PartnershipStat(),
          ),
          PartnershipStat(),
        ],
      ),
    );
  }
}
