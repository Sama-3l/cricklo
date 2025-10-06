import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.onSelectedTab,
    required this.selectedIndex,
  });

  final String title;
  final int index;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int selectedIndex;
  final Function(int index) onSelectedTab;

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<MainAppCubit>();
    return InkWell(
      onTap: () => onSelectedTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selectedIndex == index ? selectedIcon : unselectedIcon,
            size: 24,
            color: selectedIndex == index
                ? ColorsConstants.accentOrange
                : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
          ),
          Text(
            title,
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              color: selectedIndex == index
                  ? ColorsConstants.accentOrange
                  : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
