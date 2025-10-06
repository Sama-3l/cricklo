import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class PartnershipContriGraphBar extends StatelessWidget {
  const PartnershipContriGraphBar({super.key, required this.contriPercent});

  final double contriPercent;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: contriPercent,
      child: Container(
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          color: ColorsConstants.accentOrange.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
