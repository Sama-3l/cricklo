import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/theme/presentation/blocs/cubits/cubit/theme_cubit.dart';
import 'package:cricklo/features/tournament/presentation/widgets/tournament_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentsList extends StatefulWidget {
  const TournamentsList({super.key});

  @override
  State<TournamentsList> createState() => _TournamentsListState();
}

class _TournamentsListState extends State<TournamentsList> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MainAppCubit>().state;
    final themeMode = context.watch<ThemeCubit>().state; // 👈 Add this
    final isDark = themeMode == ThemeMode.dark;

    final tournaments = state.tournaments;

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: tournaments.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TournamentTile(tournamentEntity: tournaments[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        if (tournaments.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(tournaments.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: isActive ? 14 : 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDark
                            ? ColorsConstants.accentOrange
                            : ColorsConstants.accentOrange)
                      : (isDark
                            ? ColorsConstants.surfaceOrange
                            : ColorsConstants.surfaceOrange),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
      ],
    );
  }
}
