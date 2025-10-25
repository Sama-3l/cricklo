import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_players_screens/players_page.dart';
import 'package:cricklo/features/teams/presentation/screens/team_overview.dart';
import 'package:cricklo/features/teams/presentation/screens/team_stats_screens/team_profile_statistics.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key, required this.team, required this.userMatches});

  final TeamEntity team;
  final List<MatchEntity> userMatches;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TeamPageCubit>()..init(context, team),
      child: BlocBuilder<TeamPageCubit, TeamPageState>(
        builder: (context, state) {
          final cubit = context.read<TeamPageCubit>();
          final mainTabs = [
            'Team Overview',
            'Players',
            'Statistics',
            'Matches',
            'Tournaments',
          ];
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
                "Team Page",
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

                    // CONTENT
                    Expanded(
                      child: IndexedStack(
                        index: state.selectedMainTab,
                        children: [
                          TeamOverview(team: team, matches: userMatches),
                          PlayersPage(
                            selectTab: (index) => cubit.changePlayersTab(index),
                            selectedTab: state.selectedPlayersTab,
                          ),
                          TeamProfileStatistics(),
                          const Center(child: Text("No Match History")),
                          const Center(child: Text("No Tournaments Yet")),
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
