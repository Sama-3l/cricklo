import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/cubit/account_page_cubit.dart';
import 'package:cricklo/features/account/presentation/screens/player_overview.dart';
import 'package:cricklo/features/account/presentation/screens/statistics.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.userEntity});

  final UserEntity? userEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCubit()..init(userEntity),
      child: BlocBuilder<AccountCubit, AccountPageState>(
        builder: (context, state) {
          final cubit = context.read<AccountCubit>();

          // MAIN TABS LIST
          final mainTabs = [
            'Player Overview',
            'Statistics',
            'Matches',
            'Teams',
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
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: mainTabs.length,
                    itemBuilder: (context, index) {
                      final selected = state.selectedMainTab == index;
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 8.0 : 0),
                        child: InkWell(
                          onTap: () => cubit.changeMainTab(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: selected
                                  ? ColorsConstants.accentOrange
                                  : ColorsConstants.defaultBlack.withValues(
                                      alpha: 0.3,
                                    ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(
                              child: Text(
                                mainTabs[index],
                                style:
                                    (selected
                                            ? TextStyles.poppinsBold
                                            : TextStyles.poppinsRegular)
                                        .copyWith(
                                          color: ColorsConstants.defaultWhite,
                                          fontSize: 12,
                                          letterSpacing: -0.5,
                                        ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // CONTENT
                Expanded(
                  child: IndexedStack(
                    index: state.selectedMainTab,
                    children: [
                      // Player Overview
                      PlayerOverview(),

                      StatisticsPage(),

                      const Center(child: Text("Matches Page")),
                      const Center(child: Text("Teams Page")),
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
