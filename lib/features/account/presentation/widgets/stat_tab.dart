import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class StatTab extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;
  final int lastIndex;
  final Function(int index) onStatOptionTap;

  const StatTab({
    super.key,
    required this.label,
    required this.selected,
    required this.index,
    this.lastIndex = 3,
    required this.onStatOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onStatOptionTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? ColorsConstants.accentOrange : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(index == 0 ? 4 : 0),
            topRight: Radius.circular(index == lastIndex ? 4 : 0),
            bottomLeft: Radius.circular(index == 0 ? 4 : 0),
            bottomRight: Radius.circular(index == lastIndex ? 4 : 0),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style:
              (selected ? TextStyles.poppinsSemiBold : TextStyles.poppinsMedium)
                  .copyWith(
                    color: selected
                        ? ColorsConstants.defaultWhite
                        : ColorsConstants.defaultBlack,
                    fontSize: 10,
                    letterSpacing: -0.2,
                  ),
        ),
      ),
    );
  }
}
