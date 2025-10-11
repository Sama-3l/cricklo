import 'dart:math' as math;
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/innings_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_entities.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/widgets/wagon_wheel_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WagonWheelScreen extends StatefulWidget {
  const WagonWheelScreen({super.key});

  @override
  State<WagonWheelScreen> createState() => _WagonWheelScreenState();
}

class _WagonWheelScreenState extends State<WagonWheelScreen> {
  bool showPercentages = false;
  int selectedTeamIndex = 0;
  final Map<int, int> runCounts = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 6: 0};

  List<ShotData> _getShotData(InningsEntity innings) {
    final List<ShotData> shots = [];

    for (final over in innings.oversData) {
      for (final ball in over.balls) {
        if (ball.isExtra) continue;
        if (ball.sector != null) {
          shots.add(
            ShotData(
              sector: ball.sector!,
              runs: ball.runs,
              color: _getColorForRuns(ball.runs),
            ),
          );
        }
        if (runCounts.containsKey(ball.runs)) {
          runCounts[ball.runs] = runCounts[ball.runs]! + 1;
        }
      }
    }

    return shots;
  }

  Color _getColorForRuns(int runs) {
    switch (runs) {
      case 6:
        return ColorsConstants.wagonWheelStat6s;
      case 4:
        return ColorsConstants.wagonWheelStat4s;
      case 3:
        return ColorsConstants.wagonWheelStat3s;
      case 2:
        return ColorsConstants.wagonWheelStat2s;
      case 1:
        return ColorsConstants.wagonWheelStat1s;
      default:
        return ColorsConstants.wagonWheelStat1s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScorerMatchCenterCubit>();
    final state = cubit.state;

    final teamA =
        state.matchCenterEntity!.battingTeam!.id ==
            state.matchCenterEntity!.teamA.id
        ? state.matchCenterEntity!.teamA
        : state.matchCenterEntity!.teamB;
    final teamB =
        state.matchCenterEntity!.battingTeam!.id ==
            state.matchCenterEntity!.teamA.id
        ? state.matchCenterEntity!.teamB
        : state.matchCenterEntity!.teamA;
    final battingTeam = selectedTeamIndex == 0
        ? teamA
        : teamB; // currently viewed team

    final battingInnings = state.matchCenterEntity!.innings.where(
      (e) => e.battingTeam.id == battingTeam.id,
    );
    List<ShotData> shots = [];
    if (battingInnings.isNotEmpty) {
      shots = _getShotData(battingInnings.first);
    }

    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsConstants.accentOrange),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                color: ColorsConstants.accentOrange,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wagon Wheel",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultWhite,
                      fontSize: 16,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Row(
                    children: [
                      _teamToggleButton(teamA.name, 0),
                      const SizedBox(width: 8),
                      _teamToggleButton(teamB.name, 1),
                    ],
                  ),
                ],
              ),
            ),

            // Wagon Wheel
            GestureDetector(
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
                if (distance >= radius) {
                  setState(() => showPercentages = !showPercentages);

                  return;
                }
              },
              child: SizedBox(
                height: 400,
                child: CustomPaint(
                  painter: WagonWheelPainter(
                    shots: shots,
                    showPercentages: showPercentages,
                    showSectorLines: false,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorsConstants.defaultBlack,
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i in runCounts.entries)
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: _getColorForRuns(i.key),
                            child: Text(
                              "${i.key}",
                              style: TextStyles.poppinsMedium.copyWith(
                                fontSize: 12,
                                color: ColorsConstants.defaultBlack,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "${i.value}",
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultWhite,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _teamToggleButton(String title, int index) {
    final bool isSelected = selectedTeamIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTeamIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsConstants.defaultWhite
              : ColorsConstants.accentOrange,
          border: Border.all(color: ColorsConstants.defaultWhite),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 12,
            letterSpacing: -0.5,
            color: isSelected
                ? ColorsConstants.accentOrange
                : ColorsConstants.defaultWhite,
          ),
        ),
      ),
    );
  }
}
