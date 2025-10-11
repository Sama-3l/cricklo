import 'dart:math' as math;

import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/match_entities.dart';
import 'package:cricklo/features/scorer/presentation/widgets/wagon_wheel_painter.dart';
import 'package:flutter/material.dart';

class WagonWheelScreen extends StatefulWidget {
  const WagonWheelScreen({super.key});

  @override
  State<WagonWheelScreen> createState() => _WagonWheelScreenState();
}

class _WagonWheelScreenState extends State<WagonWheelScreen> {
  bool showPercentages = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final localPos = box.globalToLocal(details.globalPosition);

        final center = Offset(box.size.width / 2, box.size.height / 2);
        final dx = localPos.dx - center.dx;
        final dy = localPos.dy - center.dy;
        final distance = math.sqrt(dx * dx + dy * dy);

        final radius = box.size.width * 0.45;
        final innerRadius = radius * 0.6;

        if (distance >= innerRadius && distance <= radius) {
          setState(() => showPercentages = !showPercentages);

          return;
        }
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsConstants.accentOrange),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: ColorsConstants.accentOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "Wagon Wheel",
                style: TextStyles.poppinsSemiBold.copyWith(
                  color: ColorsConstants.defaultWhite,
                  fontSize: 16,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SizedBox(
              height: 400, // fixed height
              // width: double.infinity,
              child: CustomPaint(
                painter: WagonWheelPainter(
                  shots: [
                    ShotData(sector: 0, runs: 4, color: Colors.deepPurple),
                    ShotData(sector: 0, runs: 6, color: Colors.deepOrange),
                    ShotData(sector: 3, runs: 1, color: Colors.blueGrey),
                  ],
                  showPercentages: showPercentages,
                  showSectorLines: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
