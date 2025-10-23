import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/widgets/add_team_to_group_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsTable extends StatelessWidget {
  const PointsTable({super.key, required this.teams, required this.groupIndex});

  final List<TournamentTeamEntity> teams;
  final int groupIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    List<String> headings = ["M", "W", "L", "P", "NRR"];
    return teams.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    "No Teams Yet",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.8,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SecondaryButton(
                    title: "Add Team",
                    onTap: () async {
                      final selectedTeams = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => AddTeamToGroupBottomSheet(
                          allTeams: state.tournamentEntity!.teams,
                        ),
                      );
                      cubit.addTeamToGroup(selectedTeams, groupIndex);
                    },
                    color: ColorsConstants.defaultBlack,
                  ),
                ],
              ),
            ),
          )
        : Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(), // first column takes remaining width
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
              3: IntrinsicColumnWidth(),
              4: IntrinsicColumnWidth(),
              5: IntrinsicColumnWidth(),
            },

            border: TableBorder(
              horizontalInside: BorderSide(
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                width: 0.5,
              ),
              top: BorderSide.none,
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
              verticalInside: BorderSide.none,
            ),
            children: [
              // Header row
              TableRow(
                // decoration: const BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Teams',
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.accentOrange,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ...headings.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        e,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.accentOrange,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              ...teams.map(
                (e) => TableRow(
                  // decoration: const BoxDecoration(color: Colors.grey),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: ColorsConstants.surfaceOrange,
                            child: Icon(
                              Icons.people,
                              size: 12,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Aaryan Ji',
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...headings.map(
                      (e) => Center(
                        child: Text(
                          '0',
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
