import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class WidgetDecider {
  static Widget optionBuilder({
    required Function() onTap,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required String title,
    required bool selected,
    EdgeInsets padding = const EdgeInsets.all(0),
    bool showIcon = true,
  }) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? ColorsConstants.accentOrange.withValues(alpha: 0.2)
                : ColorsConstants.onSurfaceOrange,
            borderRadius: BorderRadius.circular(8),
            border: selected
                ? Border.all(color: ColorsConstants.accentOrange)
                : null,
          ),
          child: Row(
            children: [
              if (showIcon) ...[
                Icon(selected ? selectedIcon : unselectedIcon, size: 16),
                const SizedBox(width: 12),
              ],

              Text(
                title,
                style: TextStyles.poppinsRegular.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildOptionButton(
    String text,
    VoidCallback onPress,
    Animation<Offset> slide,
    Animation<double> opacity,
  ) {
    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: opacity,
        child: Container(
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: PrimaryButton(
            disabled: false,
            onPress: onPress,
            color: ColorsConstants.defaultWhite,
            child: Text(
              text,
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: ColorsConstants.defaultBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
