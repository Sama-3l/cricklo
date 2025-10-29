import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/theme/presentation/ThemeCubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchList extends StatefulWidget {
  const MatchList({super.key, required this.matches});

  final List<MatchEntity> matches;

  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    context.watch<MainAppCubit>().state;
    context.watch<ThemeCubit>().state;

    return Column(
      children: [
        SizedBox(
          height: 181,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.matches.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MatchTile(matchEntity: widget.matches[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        if (widget.matches.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.matches.length, (index) {
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
