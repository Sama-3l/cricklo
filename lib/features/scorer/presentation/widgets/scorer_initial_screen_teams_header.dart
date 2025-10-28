import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/presentation/widgets/scorer_team_header_item.dart';
import 'package:flutter/material.dart';

class ScorerInitialScreenTeamsHeader extends StatelessWidget {
  const ScorerInitialScreenTeamsHeader({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ScorerTeamHeaderItem(
              team: matchEntity.teamA,
              teamId: matchEntity.teamA.id,
              teamLogo: matchEntity.teamA.teamLogo,
              teamName: matchEntity.teamA.name,
              inviteAccepted:
                  matchEntity.teamA.inviteStatus == "ACCEPTED" ||
                  matchEntity.teamA.inviteStatus == null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ScorerTeamHeaderItem(
              team: matchEntity.teamB,
              teamId: matchEntity.teamB.id,
              teamLogo: matchEntity.teamB.teamLogo,
              teamName: matchEntity.teamB.name,
              inviteAccepted:
                  matchEntity.teamB.inviteStatus == "ACCEPTED" ||
                  matchEntity.teamB.inviteStatus == null,
            ),
          ),
        ],
      ),
    );
  }
}
