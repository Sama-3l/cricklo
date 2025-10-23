import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/presentation/widgets/search_teams_bottom_sheet.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamsGrid extends StatelessWidget {
  final List<TeamEntity> teams;
  final bool loading;
  final void Function(TeamEntity) onTap;
  final bool floatingButton;
  final Function(List<TeamEntity> teams)? onInviteTeams;

  const TeamsGrid({
    super.key,
    required this.teams,
    required this.loading,
    required this.onTap,
    this.floatingButton = false,
    this.onInviteTeams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingButton
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  disabled: false,
                  onPress: () async {
                    final selectedTeams = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SearchTeamsBottomSheet(
                        initiallySelected: teams,
                        multiSelect: true,
                      ),
                    );
                    if (onInviteTeams != null) {
                      onInviteTeams!(selectedTeams);
                    }
                  },
                  child: Text(
                    "Invite Teams",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      color: ColorsConstants.defaultWhite,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: loading
          ? Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: ColorsConstants.accentOrange,
                ),
              ),
            )
          : teams.isEmpty
          ? Center(
              child: Text(
                "No Teams Yet",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.accentOrange,
                ),
              ),
            )
          : Padding(
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
                          radius: 48,
                          backgroundColor: ColorsConstants.accentOrange
                              .withValues(alpha: 0.2),
                          backgroundImage: CachedNetworkImageProvider(
                            team.teamLogo,
                          ),

                          child:
                              (team.logoFile == null && team.teamLogo.isEmpty)
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
                            fontSize: 12,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultBlack,
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
