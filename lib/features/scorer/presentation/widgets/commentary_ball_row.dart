import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/ball_data_item.dart';
import 'package:flutter/material.dart';

class CommentaryBallRow extends StatelessWidget {
  final String ballNumber;
  final BallEntity ball;

  const CommentaryBallRow({
    super.key,
    required this.ballNumber,
    required this.ball,
  });

  @override
  Widget build(BuildContext context) {
    final bowler = ball.bowler?.name ?? "Unknown";
    final batsman = ball.batsman?.name ?? "Unknown";
    final desc = _generateCommentary(ball);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              ballNumber,
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
              ),
            ),
          ),
          BallDataItem(ball: ball),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$bowler → $batsman",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 12,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  desc,
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 10,
                    letterSpacing: -0.2,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _generateCommentary(BallEntity ball) {
    if (ball.wicketType != null) {
      return "Dismissed: ${ball.wicketType.toString().split('.').last}";
    } else if (ball.isExtra) {
      return "Extra: ${ball.extraType.toString().split('.').last}";
    } else if (ball.runs == 4) {
      return "Beautifully timed for four!";
    } else if (ball.runs == 6) {
      return "Smashed out of the park!";
    } else if (ball.runs == 0) {
      return "Good length, defended.";
    } else {
      return "Ran ${ball.runs} run${ball.runs > 1 ? 's' : ''}.";
    }
  }
}
