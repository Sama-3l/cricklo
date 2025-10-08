import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatelessWidget {
  final MatchEntity matchEntity;
  final bool live;

  const MatchTile({super.key, required this.matchEntity, this.live = false});

  @override
  Widget build(BuildContext context) {
    // final teamA = matchEntity.teamA;
    // final teamB = matchEntity.teamB;
    // final matchStage = Methods.ge(matchEntity);

    // final isTeamAWinner = matchEntity.winner == matchEntity.teamA.id;
    // final isTeamBWinner = matchEntity.winner == matchEntity.teamB.id;
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Top row: Team images + VS + LIVE
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dummy Match",
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 12,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                    letterSpacing: -0.5,
                  ),
                ),
                DateTime.now().difference(matchEntity.dateAndTime).inSeconds >=
                        0
                    ? matchEntity.tossWinner == null
                          ? Text(
                              "(Delayed)\n${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: false)}",
                              textAlign: TextAlign.end,
                              style: TextStyles.poppinsSemiBold.copyWith(
                                color: ColorsConstants.defaultBlack,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            )
                          : matchEntity.winner == null
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: ColorsConstants.warningRed,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "LIVE",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  color: ColorsConstants.defaultWhite,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            )
                          : Text(
                              Methods.formatDateTime(matchEntity.dateAndTime),
                              textAlign: TextAlign.end,
                              style: TextStyles.poppinsSemiBold.copyWith(
                                color: ColorsConstants.defaultBlack,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            )
                    : Text(
                        Methods.formatDateTime(matchEntity.dateAndTime),
                        textAlign: TextAlign.end,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          color: ColorsConstants.defaultBlack,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 12),

            Column(
              children: [
                WidgetDecider.buildTeamRow(
                  matchEntity.teamA,
                  matchEntity.teamAScore,
                  matchEntity,
                ),
                const SizedBox(height: 8),
                WidgetDecider.buildTeamRow(
                  matchEntity.teamB,
                  matchEntity.teamBScore,
                  matchEntity,
                ),
                const SizedBox(height: 12),
                Text(
                  "${matchEntity.location.location!}, ${matchEntity.location.area}, ${matchEntity.location.city}, ${matchEntity.location.state}",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 10,
                    letterSpacing: -0.2,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
