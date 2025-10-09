import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/cubit/scorer_center_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreKeepingCenter extends StatelessWidget {
  const ScoreKeepingCenter({super.key});

  Widget _cell(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
            color: ColorsConstants.defaultWhite,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreCenterCubit(),
      child: BlocBuilder<ScoreCenterCubit, ScoreCenterState>(
        builder: (context, state) {
          final cubit = context.read<ScoreCenterCubit>();
          return Table(
            columnWidths: const {
              0: FlexColumnWidth(), // Batsman name wider
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
            },
            border: TableBorder(
              horizontalInside: BorderSide(color: ColorsConstants.defaultWhite),
              verticalInside: BorderSide(color: ColorsConstants.defaultWhite),
            ),
            children: [
              // 🟠 Header Row
              TableRow(
                decoration: BoxDecoration(
                  color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
                ),
                children: [
                  _cell("1"),
                  _cell("2"),
                  _cell("3"),
                  _cell("4"),
                  _cell("6"),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
                ),
                children: [
                  _cell("LB"),
                  _cell("Bye"),
                  _cell("Wide"),
                  _cell("NB"),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
                ),
                children: [
                  _cell("More"),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.sports_baseball,
                        color: ColorsConstants.defaultWhite,
                      ),
                    ),
                  ),
                  _cell("4 5 6 7"),
                  _cell("Undo"),
                  _cell("Out"),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
