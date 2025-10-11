import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/ball_data_item.dart';
import 'package:flutter/material.dart';

class LastBallsRow extends StatelessWidget {
  final List<OversEntity> overs;

  const LastBallsRow({super.key, required this.overs});

  @override
  Widget build(BuildContext context) {
    final items = Methods.getLastBallsWithBreaks(overs);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: items.map((item) {
          if (item == "-") {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text("-", style: TextStyle(fontSize: 18)),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: BallDataItem(ball: item as BallEntity),
            );
          }
        }).toList(),
      ),
    );
  }
}
