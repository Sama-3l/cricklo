import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/theme/presentation/blocs/cubits/cubit/theme_cubit.dart';
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
    final state = context.watch<MainAppCubit>().state;
    context.watch<ThemeCubit>().state; // 👈 add this line

    final matches =
        state.matches.where((e) => e.teamA.inviteStatus != null).toList()
          ..sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));

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

        if (matches.length > 1)
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
                      : ColorsConstants.surfaceOrange,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
      ],
    );
  }
}
