import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/AccountPageCubit/account_page_cubit.dart';
import 'package:cricklo/features/account/presentation/screens/player_overview.dart';
import 'package:cricklo/features/account/presentation/screens/statistics.dart';
import 'package:cricklo/features/account/presentation/screens/teams_grid.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
    required this.userEntity,
    required this.userMatches,
  });

  final UserEntity? userEntity;
  final List<MatchEntity> userMatches;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AccountCubit>()..init(userEntity),
      child: BlocBuilder<AccountCubit, AccountPageState>(
        builder: (context, state) {
          final cubit = context.read<AccountCubit>();

          // MAIN TABS LIST
          final mainTabs = [
            'Player Overview',
            'Statistics',
            'Teams',
            'Matches',
            'Tournaments',
          ];
          if (state.userEntity == null) {
            return Center(
              child: Text(
                "Please login/sign-up to view",
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
                      PlayerOverview(),

                      StatisticsPage(),

                      TeamsGrid(
                        teams: state.teams,
                        onTap: (team) => GoRouter.of(context).pushNamed(
                          Routes.teamPage,
                          extra: [team, userMatches],
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
    );
  }
}
