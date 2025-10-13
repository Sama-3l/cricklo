import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';

class ActiveSquad extends StatelessWidget {
  const ActiveSquad({super.key, required this.team});

  final TeamEntity? team;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: WidgetDecider.buildActivePlayersList(
            team == null ? [] : team!.players,
          ),
        ),
      ),
    );
  }
}
