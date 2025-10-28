import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/widgets/add_team_to_group_bottom_sheet.dart';
import 'package:cricklo/features/tournament/presentation/widgets/points_table.dart';
import 'package:cricklo/features/tournament/presentation/widgets/shimmer_points_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    return state.tournamentEntity!.tournamentType == TournamentType.knockout
        ? Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                if (state.tournamentEntity!.organizerId ==
                        GlobalVariables.user!.profileId &&
                    state.tournamentEntity!.groupMatches.isEmpty &&
                    !state.loading)
                  Row(
                    children: [
                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SecondaryButton(
                          onTap: () => cubit.addGroup(context),
                          title: "Create Group",
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                state.loading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SectionHeader(
                              title: "Group Table",
                              showIcon: false,
                            ),
                            ShimmerTable(headings: ["M", "W", "L", "P", "NRR"]),
                          ],
                        ),
                      )
                    : state.tournamentEntity == null ||
                          state.tournamentEntity!.groups.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "No Groups Yet",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 24,
                              letterSpacing: -1.2,
                              color: ColorsConstants.accentOrange,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: state.tournamentEntity!.groups.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Divider(
                              color: ColorsConstants.onSurfaceGrey,
                              thickness: 2,
                            ),
                          ),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SectionHeader(
                                        title: state
                                            .tournamentEntity!
                                            .groups[index]
                                            .name,
                                        showIcon: false,
                                      ),
                                    ),
                                    if (state.tournamentEntity!.organizerId ==
                                            GlobalVariables.user!.profileId &&
                                        state
                                            .tournamentEntity!
                                            .groupMatches
                                            .isEmpty) ...[
                                      InkWell(
                                        onTap: () =>
                                            cubit.removeGroup(context, index),
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.delete,
                                            color: ColorsConstants.defaultBlack,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      InkWell(
                                        onTap: () =>
                                            cubit.editGroup(context, index),
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.edit,
                                            color: ColorsConstants.defaultBlack,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      InkWell(
                                        onTap: () async {
                                          final alreadyAddedTeams =
                                              <TournamentTeamEntity>[];
                                          for (var teams
                                              in state.tournamentEntity!.groups
                                                  .map((e) => e.teams)) {
                                            alreadyAddedTeams.addAll(teams);
                                          }
                                          final alreadyAddedTeamIds =
                                              alreadyAddedTeams.map(
                                                (e) => e.id,
                                              );
                                          final selectedTeams =
                                              await showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) =>
                                                    AddTeamToGroupBottomSheet(
                                                      allTeams: state
                                                          .tournamentEntity!
                                                          .teams
                                                          .where(
                                                            (e) =>
                                                                !alreadyAddedTeamIds
                                                                    .contains(
                                                                      e.id,
                                                                    ),
                                                          )
                                                          .toList(),
                                                    ),
                                              );
                                          if (selectedTeams != null &&
                                              (selectedTeams
                                                      as List<
                                                        TournamentTeamEntity
                                                      >)
                                                  .isNotEmpty) {
                                            cubit.addTeamToGroup(
                                              context,
                                              selectedTeams,
                                              index,
                                            );
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  ColorsConstants.defaultBlack,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.add,
                                            color: ColorsConstants.defaultBlack,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                PointsTable(
                                  teams: state
                                      .tournamentEntity!
                                      .groups[index]
                                      .teams,
                                  groupIndex: index,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                state.loading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SectionHeader(
                              title: "League Group",
                              showIcon: false,
                            ),
                            ShimmerTable(headings: ["M", "W", "L", "P", "NRR"]),
                          ],
                        ),
                      )
                    : state.tournamentEntity == null ||
                          state.tournamentEntity!.groups.isEmpty
                    ? state.tournamentEntity!.organizerId ==
                              GlobalVariables.user!.profileId
                          ? Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: SecondaryButton(
                                    onTap: () =>
                                        cubit.createLeaguePointsTable(context),
                                    title: "Create Points Table",
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text(
                                  "No Points Table Yet",
                                  style: TextStyles.poppinsSemiBold.copyWith(
                                    fontSize: 24,
                                    letterSpacing: -1.2,
                                    color: ColorsConstants.accentOrange,
                                  ),
                                ),
                              ),
                            )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: state.tournamentEntity!.groups.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Divider(
                              color: ColorsConstants.onSurfaceGrey,
                              thickness: 2,
                            ),
                          ),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SectionHeader(
                                  title: state
                                      .tournamentEntity!
                                      .groups[index]
                                      .name,
                                  showIcon: false,
                                ),
                                PointsTable(
                                  teams: state
                                      .tournamentEntity!
                                      .groups[index]
                                      .teams,
                                  groupIndex: index,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
  }
}
