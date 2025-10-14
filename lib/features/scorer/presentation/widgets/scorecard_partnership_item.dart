import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/scorer/domain/entities/partnership_entity.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScorecardPartnershipItem extends StatelessWidget {
  const ScorecardPartnershipItem({super.key, required this.partnershipEntity});

  final PartnershipEntity partnershipEntity;

  @override
  Widget build(BuildContext context) {
    final state = context.read<ScorerMatchCenterCubit>().state;
    final inningsIndex = state.matchCenterEntity!.innings.length <= 2 ? 0 : 1;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 8),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partnershipEntity.player1!.name,
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "${partnershipEntity.player1!.stats[inningsIndex].runs} (${partnershipEntity.player1!.stats[inningsIndex].balls})",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsConstants.accentOrange),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Text(
                      partnershipEntity.runs.toString(),
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.accentOrange,
                      ),
                    ),
                  ),
                ),
                Text(
                  "${partnershipEntity.balls} balls",
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 12,
                    letterSpacing: -0.5,
                    color: ColorsConstants.accentOrange,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    partnershipEntity.player2!.name,
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "${partnershipEntity.player2!.stats[inningsIndex].runs} (${partnershipEntity.player2!.stats[inningsIndex].balls})",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
