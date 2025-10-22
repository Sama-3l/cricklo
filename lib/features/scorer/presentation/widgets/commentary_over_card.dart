import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/ball_data_item.dart';
import 'package:flutter/material.dart';

class CommentaryOverCard extends StatelessWidget {
  final OversEntity over;

  const CommentaryOverCard({super.key, required this.over});

  @override
  Widget build(BuildContext context) {
    final balls = over.balls;
    final runsInOver = balls.fold(0, (sum, b) => sum + b.runs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorsConstants.onSurfaceGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: balls.map((b) => BallDataItem(ball: b)).toList(),
              ),
              const Divider(height: 16, thickness: 1),
              _buildStatsSection(over),
              const Divider(height: 16, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Overs  ${over.overNumber}",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.accentOrange,
                    ),
                  ),
                  Text(
                    "Runs  $runsInOver",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.accentOrange,
                    ),
                  ),
                  Text(
                    "Score  ${over.runs + over.overRuns} - ${over.wickets + over.overWickets}",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.accentOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ...WidgetDecider.renderCommentaryBallWidget(balls, over),
      ],
    );
  }

  Widget _buildStatsSection(OversEntity over) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Batsmen Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    over.player1Name,
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "${over.player1runs} (${over.player1balls})",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    over.player2Name,
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "${over.player2runs} (${over.player2balls})",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                over.bowlerName,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                "${over.bowlerOvers} - ${over.bowlerMaidens} - ${over.bowlerRuns} - ${over.bowlerWickets}",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
