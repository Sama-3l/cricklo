import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    super.key,
    required this.onTap,
    required this.mainTabs,
    required this.selectedMainTab,
    this.fontsize = 12,
    this.height = 40,
    this.row = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final Function(int index) onTap;
  final List<String> mainTabs;
  final double fontsize;
  final double height;
  final EdgeInsets padding;
  final bool row;

  final int selectedMainTab;

  List<Widget> renderOptions() {
    List<Widget> children = [];
    for (int index = 0; index < mainTabs.length; index++) {
      final selected = selectedMainTab == index;
      children.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected
                    ? ColorsConstants.accentOrange
                    : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text(
                  mainTabs[index],
                  style:
                      (selected
                              ? TextStyles.poppinsBold
                              : TextStyles.poppinsRegular)
                          .copyWith(
                            color: ColorsConstants.defaultWhite,
                            fontSize: fontsize,
                            letterSpacing: -0.5,
                          ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: row
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: renderOptions(),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              scrollDirection: Axis.horizontal,
              itemCount: mainTabs.length,
              itemBuilder: (context, index) {
                final selected = selectedMainTab == index;
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 8.0 : 0,
                    right: index == mainTabs.length - 1 ? 8 : 0,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () => onTap(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: selected
                            ? ColorsConstants.accentOrange
                            : ColorsConstants.defaultBlack.withValues(
                                alpha: 0.3,
                              ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Text(
                          mainTabs[index],
                          style:
                              (selected
                                      ? TextStyles.poppinsBold
                                      : TextStyles.poppinsRegular)
                                  .copyWith(
                                    color: ColorsConstants.defaultWhite,
                                    fontSize: fontsize,
                                    letterSpacing: -0.5,
                                  ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
