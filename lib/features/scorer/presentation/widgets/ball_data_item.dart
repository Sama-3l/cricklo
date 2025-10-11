import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:flutter/material.dart';

class BallDataItem extends StatelessWidget {
  const BallDataItem({super.key, required this.ball});

  final BallEntity ball;

  Color _getBackgroundColor() {
    if (ball.wicketType != null) {
      if (ball.wicketType == WicketType.retired) {
        return ColorsConstants.defaultBlack.withValues(alpha: 0.5);
      }
      return ColorsConstants.warningRed;
    }

    if (ball.runs >= 4) return ColorsConstants.urlBlue;
    return Colors.grey.shade400;
  }

  String _getDisplayText() {
    if (ball.wicketType != null) {
      final w = ball.wicketType!;
      if (w == WicketType.retired) return "R";
      if (ball.extraType != null && ball.extraType != ExtraType.none) {
        return "W+${_extraAbbr(ball.extraType!)}${ball.runs > 0 ? "+${ball.runs}" : ""}";
      }
      return "W";
    }

    if (ball.extraType != null && ball.extraType != ExtraType.none) {
      final extra = _extraAbbr(ball.extraType!);
      return ball.runs > 0 ? "$extra+${ball.runs}" : extra;
    }

    if (ball.runs == 0) return "0";
    return "${ball.runs}";
  }

  String _extraAbbr(ExtraType extra) {
    switch (extra) {
      case ExtraType.wide:
        return "Wd";
      case ExtraType.noBall:
        return "NB";
      case ExtraType.bye:
        return "B";
      case ExtraType.legBye:
        return "LB";
      default:
        return "";
    }
  }

  double _getFontSizeForText(String text) {
    if (text.length <= 2) return 12;
    if (text.length <= 4) return 10;
    if (text.length <= 6) return 9;
    return 8;
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final text = _getDisplayText();
    final fontSize = _getFontSizeForText(text);

    return CircleAvatar(
      radius: 16,
      backgroundColor: bgColor,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyles.poppinsBold.copyWith(
              fontSize: fontSize,
              letterSpacing: -0.4,
              color: ColorsConstants.defaultWhite,
            ),
          ),
        ),
      ),
    );
  }
}
