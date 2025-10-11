import 'dart:math' as math;

import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/match_entities.dart';
import 'package:flutter/material.dart';

class WagonWheelPainter extends CustomPainter {
  final List<ShotData> shots;
  final bool showPercentages;
  final bool showSectorLines;

  WagonWheelPainter({
    required this.shots,
    required this.showPercentages,
    this.showSectorLines = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.45;
    final pitchHeight = radius * 0.2;

    final basePaint = Paint()
      ..color = ColorsConstants.wagonWheelField
      ..style = PaintingStyle.fill;

    final ringPaint = Paint()
      ..color = ColorsConstants.wagonWheelStatBackground
      ..style = PaintingStyle.fill;

    final ringStroke = Paint()
      ..color = ColorsConstants.defaultWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final sectorLine = Paint()
      ..color = ColorsConstants.defaultWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;

    final borderPaint = Paint()
      ..color = ColorsConstants.defaultWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final ellipseRect = Rect.fromCenter(
      center: center,
      width: radius * 0.5,
      height: radius * 0.65,
    );

    final ellipsePaint = Paint()
      ..color = ColorsConstants.defaultWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Background circles
    canvas.drawCircle(center, radius, ringPaint);
    canvas.drawCircle(center, radius * 0.75, basePaint);
    canvas.drawCircle(center, radius * 0.7, ringStroke);
    canvas.drawOval(ellipseRect, ellipsePaint);

    // Pitch
    final pitch = Rect.fromCenter(
      center: center,
      width: radius * 0.08,
      height: pitchHeight,
    );
    canvas.drawRect(pitch, Paint()..color = ColorsConstants.wagonWheelPitch);

    // Sectors
    const sectors = 8;
    const angleStep = 2 * math.pi / sectors;
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Calculate total runs and shots per sector
    final sectorRuns = List.generate(sectors, (_) => 0);
    final sectorShots = List.generate(sectors, (_) => 0);

    for (final s in shots) {
      sectorRuns[s.sector] += s.runs;
      sectorShots[s.sector]++;
    }

    // Draw sector dividers and values
    for (int i = 0; i < sectors; i++) {
      final startAngle = i * angleStep;

      // Divider lines
      final dividerStart = Offset(
        center.dx + radius * 0.75 * math.cos(startAngle),
        center.dy + radius * 0.75 * math.sin(startAngle),
      );
      final dividerEnd = Offset(
        center.dx + radius * math.cos(startAngle),
        center.dy + radius * math.sin(startAngle),
      );
      if (showSectorLines) {
        canvas.drawLine(center, dividerStart, sectorLine);
      }

      canvas.drawLine(dividerStart, dividerEnd, borderPaint);

      // Runs / Percentages text
      final value = showPercentages
          ? (shots.isEmpty
                ? 0
                : ((sectorShots[i] / shots.length) * 100).round())
          : sectorRuns[i];

      final x =
          center.dx + (radius * 0.875) * math.cos(startAngle + angleStep / 2);
      final y =
          center.dy + (radius * 0.875) * math.sin(startAngle + angleStep / 2);

      textPainter.text = TextSpan(
        text: "$value${showPercentages ? "%" : ""}",
        style: TextStyles.poppinsSemiBold.copyWith(
          color: ColorsConstants.defaultWhite,
          fontSize: 12,
          letterSpacing: -0.8,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    // Draw shots, evenly distributed per sector
    final sectorShotsMap = List.generate(sectors, (_) => <ShotData>[]);
    for (final shot in shots) {
      sectorShotsMap[shot.sector].add(shot);
    }

    for (int i = 0; i < sectors; i++) {
      final shotsInSector = sectorShotsMap[i];
      if (shotsInSector.isEmpty) continue;

      final sectorStart = i * angleStep;
      final count = shotsInSector.length;

      for (int j = 0; j < count; j++) {
        final angle = sectorStart + (j + 0.5) * angleStep / count;
        final shot = shotsInSector[j];

        final endPoint = Offset(
          center.dx + radius * 0.7 * math.cos(angle),
          center.dy + radius * 0.7 * math.sin(angle),
        );
        final linePaint = Paint()
          ..color = shot.color
          ..strokeWidth = 2;

        canvas.drawLine(center.translate(0, -15), endPoint, linePaint);
      }
    }

    // Outer border
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant WagonWheelPainter oldDelegate) =>
      oldDelegate.shots != shots ||
      oldDelegate.showPercentages != showPercentages;
}
