import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/mainapp/presentation/widgets/custom_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsConstants.defaultWhite,
        boxShadow: [
          BoxShadow(
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.3),
            blurRadius: 32,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: CustomTab(
                index: 0,
                title: "Home",
                selectedIcon: Icons.home,
                unselectedIcon: Icons.home_outlined,
              ),
            ),
            Expanded(
              child: CustomTab(
                index: 1,
                title: "Matches",
                selectedIcon: Icons.sports_cricket,
                unselectedIcon: Icons.sports_cricket_outlined,
              ),
            ),
            Expanded(
              child: CustomTab(
                index: 2,
                title: "Tournaments",
                selectedIcon: Icons.emoji_events,
                unselectedIcon: Icons.emoji_events_outlined,
              ),
            ),
            Expanded(
              child: CustomTab(
                index: 3,
                title: "Account",
                selectedIcon: CupertinoIcons.person_circle_fill,
                unselectedIcon: CupertinoIcons.person_circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
