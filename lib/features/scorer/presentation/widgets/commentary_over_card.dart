import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/ball_data_item.dart';
import 'package:cricklo/features/scorer/presentation/widgets/commentary_ball_row.dart';
import 'package:flutter/material.dart';

class CommentaryOverCard extends StatelessWidget {
  final OversEntity over;

  const CommentaryOverCard({super.key, required this.over});

  @override
  Widget build(BuildContext context) {
    final balls = over.balls;
    final runsInOver = balls.fold(0, (sum, b) => sum + b.runs);
    final wickets = balls.where((b) => b.wicketType != null).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
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
    // Placeholder – you’ll pull these from live team stats at end of over
    final batsmen = [over.balls.last.batsman, over.balls.last.secondBatsman];
    final bowler = over.balls.last.bowler;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Batsmen Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: batsmen
                .map(
                  (b) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        b!.name,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        "${b.stats.runs} (${b.stats.balls})",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bowler!.name,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                "${bowler.stats.overs} - ${bowler.stats.maidens} - ${bowler.stats.runsGiven} - ${bowler.stats.wickets}",
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
