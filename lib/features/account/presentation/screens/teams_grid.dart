import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';

class TeamsGrid extends StatelessWidget {
  final List<TeamEntity> teams;
  final void Function(TeamEntity) onTap;

  const TeamsGrid({super.key, required this.teams, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          childAspectRatio: 1,
        ),
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];

          return GestureDetector(
            onTap: () => onTap(team),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorsConstants.accentOrange.withValues(
                    alpha: 0.2,
                  ),
                  backgroundImage: AssetImage(team.teamLogo),

                  child: (team.logoFile == null && team.teamLogo.isEmpty)
                      ? Icon(
                          Icons.people,
                          size: 32,
                          color: ColorsConstants.defaultBlack,
                        )
                      : null,
                ),

                const SizedBox(height: 8),

                Text(
                  team.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 14,
                    color: ColorsConstants.defaultBlack,
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
