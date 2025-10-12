import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchList extends StatefulWidget {
  const MatchList({super.key});

  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.read<MainAppCubit>().state;
    final matches = state.matches.reversed.toList();
    return Column(
      children: [
        SizedBox(
          height: 181,
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
          children: List.generate(state.matches.length, (index) {
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
