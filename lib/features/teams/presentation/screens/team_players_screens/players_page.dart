import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/screens/team_players_screens/active_squad.dart';
import 'package:cricklo/features/teams/presentation/screens/team_players_screens/alphabetical_order_players.dart';
import 'package:cricklo/features/teams/presentation/screens/team_players_screens/players_role_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({
    super.key,
    required this.selectTab,
    required this.selectedTab,
  });

  final Function(int index) selectTab;
  final int selectedTab;

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<TeamPageCubit>().state;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: ColorsConstants.defaultWhite,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                disabled: false,
                child: Text(
                  "Find More Players",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.6,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: StatsTableFilterTabBar(
              options: ["Role", "A-Z", "Squad", "Invites"],
              selectTab: widget.selectTab,
              selectedTab: widget.selectedTab,
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: widget.selectedTab,
              children: [
                PlayersRolePage(teamEntity: state.team),
                AlphabeticalOrderPlayers(team: state.team),
                ActiveSquad(team: state.team),
                PlayersRolePage(teamEntity: state.team, invites: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
