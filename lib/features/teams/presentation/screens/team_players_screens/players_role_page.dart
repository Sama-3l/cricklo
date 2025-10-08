import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';

class PlayersRolePage extends StatelessWidget {
  const PlayersRolePage({
    super.key,
    required this.teamEntity,
    this.invites = false,
  });

  final TeamEntity teamEntity;
  final bool invites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: WidgetDecider.buildPlayerList(
            teamEntity.players,
            showInvited: invites,
            onDismiss: (playerId) {},
          ),
        ),
      ),
    );
  }
}
