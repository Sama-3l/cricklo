import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';
// import your ColorsConstants and TextStyles if not already in scope

class StatsTableFilterTabBar extends StatelessWidget {
  final int selectedTab;
  final Function(int) selectTab;
  final List<String> options;
  final bool whiteBackground;

  const StatsTableFilterTabBar({
    super.key,
    required this.selectedTab,
    required this.selectTab,
    required this.options,
    this.whiteBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width - 32; // adjust for screen padding
    final segmentWidth = width / options.length;

    return Container(
      decoration: BoxDecoration(
        color: whiteBackground
            ? ColorsConstants.defaultWhite
            : ColorsConstants.onSurfaceGrey,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Animated background for selected tab
          AnimatedAlign(
            alignment: _alignmentForIndex(selectedTab, options.length),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Container(
              width: selectedTab == 0 || selectedTab == options.length - 1
                  ? segmentWidth
                  : segmentWidth - 8,
              height: 36,
              decoration: BoxDecoration(
                color: ColorsConstants.accentOrange,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),

          // Options row
          Row(
            children: List.generate(options.length, (index) {
              final isSelected = selectedTab == index;
              return Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(32),
                  onTap: () => selectTab(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      options[index],
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: isSelected
                            ? ColorsConstants.defaultWhite
                            : ColorsConstants.defaultBlack,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Alignment _alignmentForIndex(int index, int length) {
    if (length == 1) return Alignment.center;
    if (length == 2) {
      return index == 0 ? Alignment.centerLeft : Alignment.centerRight;
    }

    // Evenly distribute for >2 options
    final step = 2 / (length - 1);
    final x = -1.0 + (index * step);
    return Alignment(x, 0);
  }
}
