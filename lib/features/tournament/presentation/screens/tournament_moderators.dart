import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/teams/presentation/widgets/search_players_bottom_sheet.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TournamentModerators extends StatelessWidget {
  const TournamentModerators({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: 16),
        child:
            state.tournamentEntity!.organizerId ==
                GlobalVariables.user!.profileId
            ? SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  disabled: false,
                  onPress: () async {
                    final selectedModerators = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SearchPlayersBottomSheet(
                        initiallySelected: state.tournamentEntity!.moderators,
                      ),
                    );
                    cubit.addModerator(
                      context,
                      (selectedModerators as List<SearchUserEntity>)
                          .map(
                            (e) =>
                                e.copyWith(inviteStatus: InviteStatus.invited),
                          )
                          .toList(),
                    );
                  },
                  child: Text(
                    "Invite Moderators",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      color: ColorsConstants.defaultWhite,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: state.loading
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(top: 24),
              child: ListView.builder(
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Shimmer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Profile circle shimmer
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Name + ID shimmer
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: 80,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: ColorsConstants.defaultBlack
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Invite status shimmer
                        Container(
                          width: 50,
                          height: 12,
                          decoration: BoxDecoration(
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : state.tournamentEntity!.moderators.isEmpty
          ? Center(
              child: Text(
                "No Moderators Yet",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.accentOrange,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(top: 24),
              child: ListView.builder(
                itemCount: state.tournamentEntity!.moderators.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorsConstants.accentOrange
                            .withValues(alpha: 0.2),
                        child: Icon(
                          CupertinoIcons.person_fill,
                          size: 16,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.tournamentEntity!.moderators[index].name,
                              style: TextStyles.poppinsMedium.copyWith(
                                fontSize: 16,
                                color: ColorsConstants.defaultBlack,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state
                                  .tournamentEntity!
                                  .moderators[index]
                                  .playerId,
                              style: TextStyles.poppinsRegular.copyWith(
                                fontSize: 10,
                                color: ColorsConstants.defaultBlack,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        state
                            .tournamentEntity!
                            .moderators[index]
                            .inviteStatus!
                            .title,
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          color: ColorsConstants.defaultBlack,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
