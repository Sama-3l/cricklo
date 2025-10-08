import 'package:cricklo/core/utils/constants/dummy_data.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:flutter/material.dart';

class MatchList extends StatefulWidget {
  const MatchList({super.key});

  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  final matches = [
    dummyMatchScheduled,
    dummyMatchLive,
    dummyMatchTossDone,
    dummyMatchInningsTwo,
    dummyMatchDone,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            controller: _pageController,
            itemCount: matches.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MatchTile(live: index == 0, matchEntity: matches[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(matches.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: isActive ? 14 : 6,
              decoration: BoxDecoration(
                color: isActive
                    ? ColorsConstants.accentOrange
                    : ColorsConstants.accentOrange.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
