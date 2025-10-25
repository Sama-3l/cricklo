import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/ProfilePageCubit/profile_page_cubit.dart';
import 'package:cricklo/features/account/presentation/screens/player_overview.dart';
import 'package:cricklo/features/account/presentation/screens/statistics.dart';
import 'package:cricklo/features/account/presentation/screens/teams_grid.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsConstants.defaultWhite),
        backgroundColor: ColorsConstants.accentOrange,
        title: Text(
          "Profile Page",
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 24,
            letterSpacing: -1.2,
            color: ColorsConstants.defaultWhite,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => sl<ProfilePageCubit>()..init(userId),
        child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            final cubit = context.read<ProfilePageCubit>();
            final state = cubit.state;
            // MAIN TABS LIST
            final mainTabs = [
              'Player Overview',
              'Statistics',
              'Teams',
              'Matches',
              'Tournaments',
            ];
            if (state.loading) {
              return Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: ColorsConstants.accentOrange,
                  ),
                ),
              );
            }
            if (state.userEntity == null) {
              return Center(
                child: Text(
                  "No Profile Found",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                ),
              );
            }

            return Padding(
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
                        // Player Overview
                        PlayerOverview(
                          userEntity: state.userEntity!,
                          onFollow: () => cubit.followButton(context),
                        ),

                        StatisticsPage(
                          selectedStatisticsTab: state.selectedStatisticsTab,
                          changeStatisticsTab: (index) =>
                              cubit.changeStatisticsTab(index),
                        ),

                        TeamsGrid(
                          loading: state.teamsLoading,
                          teams: state.teams,
                          onTap: (team) => GoRouter.of(context).pushNamed(
                            Routes.teamPage,
                            extra: [team, <MatchEntity>[]],
                          ),
                        ),
                        const Center(child: Text("Matches Page")),
                        const Center(child: Text("Tournaments Page")),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
