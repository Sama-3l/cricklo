import 'package:cricklo/features/scorer/domain/entities/shot_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/wagon_wheel_painter.dart';
import 'package:flutter/material.dart';

class WagonWheelView extends StatefulWidget {
  final List<ShotData> shots; // Each shot contains sector, runs, color, etc.
  final bool showSectorLines;
  const WagonWheelView({
    super.key,
    required this.shots,
    this.showSectorLines = true,
  });

  @override
  State<WagonWheelView> createState() => _WagonWheelViewState();
}

class _WagonWheelViewState extends State<WagonWheelView> {
  bool showPercentages = false;
  int? tappedSector;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: WagonWheelPainter(
            showSectorLines: widget.showSectorLines,
            shots: widget.shots,
            showPercentages: showPercentages,
          ),
        ),
      ),
    );
  }
}
