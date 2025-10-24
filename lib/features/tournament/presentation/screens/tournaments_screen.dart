import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/tournament/presentation/widgets/shimmer_tournament_tile.dart';
import 'package:cricklo/features/tournament/presentation/widgets/tournament_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentsScreen extends StatelessWidget {
  const TournamentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<MainAppCubit>().state;
    return Scaffold(
      backgroundColor: ColorsConstants.onSurfaceGrey,
      body: RefreshIndicator(
        color: ColorsConstants.accentOrange,
        onRefresh: () async {
          await context.read<MainAppCubit>().getTournaments();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(top: 24),
              child: SectionHeader(
                title: "Tournaments Explore",
                showIcon: false,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: state.tournamentLoading
                  ? ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ShimmerTournamentTile();
                      },
                    )
                  : state.tournaments.isEmpty
                  ? Container(
                      height: 200,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorsConstants.defaultWhite,
                      ),
                      child: Center(
                        child: Text(
                          "No Tournaments Yet",
                          style: TextStyles.poppinsRegular.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: state.tournaments.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 300,
                            child: TournamentTile(
                              tournamentEntity: state.tournaments[index],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
