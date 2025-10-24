import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/widgets/points_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          if (state.tournamentEntity!.organizerId ==
              GlobalVariables.user!.profileId)
            Row(
              children: [
                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SecondaryButton(
                    onTap: () => cubit.addGroup(),
                    title: "Create Group",
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          state.tournamentEntity == null ||
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SectionHeader(
                                  title:
                                      "Group ${String.fromCharCode(65 + index)}",
                                  showIcon: false,
                                ),
                              ),
                              InkWell(
                                onTap: () => cubit.removeGroup(index),
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.delete,
                                    color: ColorsConstants.defaultBlack,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          PointsTable(
                            teams: state.tournamentEntity!.groups[index].teams,
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
