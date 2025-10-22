import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/screens/teams_grid.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/screens/points_page.dart';
import 'package:cricklo/features/tournament/presentation/screens/stats_page.dart';
import 'package:cricklo/features/tournament/presentation/screens/tournament_overview.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({super.key, required this.tournamentEntity});

  final TournamentEntity tournamentEntity;

  @override
  Widget build(BuildContext context) {
    final mainTabs = ['Home', 'Matches', 'Teams', 'Points', 'Statistics'];
    return BlocProvider(
      create: (context) => TournamentCubit()..init(tournamentEntity),
      child: BlocBuilder<TournamentCubit, TournamentState>(
        builder: (context, state) {
          final cubit = context.read<TournamentCubit>();
          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              backgroundColor: ColorsConstants.accentOrange,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: ColorsConstants.defaultWhite,
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  );
                },
              ),
              title: Text(
                "Tournament Page",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),

              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Column(
                  children: [
                    ProfileTabBar(
                      onTap: (index) => cubit.changeMainTab(index),
                      mainTabs: mainTabs,
                      selectedMainTab: state.selectedMainTab,
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: state.selectedMainTab,
                        children: [
                          TournamentOverview(),
                          const Center(child: Text("No Match History")),
                          TeamsGrid(
                            loading: false,
                            teams: state.tournamentEntity!.teams,
                            onTap: (team) => GoRouter.of(context).pushNamed(
                              Routes.teamPage,
                              extra: [team, <MatchEntity>[]],
                            ),
                          ),
                          PointsPage(),
                          StatsPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
