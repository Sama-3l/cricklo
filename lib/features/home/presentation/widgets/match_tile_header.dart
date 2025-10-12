import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchTileHeader extends StatelessWidget {
  const MatchTileHeader({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  Widget build(BuildContext context) {
    return GlobalVariables.user != null &&
            matchEntity.scorer["playerId"] == GlobalVariables.user!.profileId
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dummy Match",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      letterSpacing: -0.5,
                    ),
                  ),
                  DateTime.now()
                              .difference(matchEntity.dateAndTime)
                              .inSeconds >=
                          0
                      ? matchEntity.tossWinner == null
                            ? Text(
                                "${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: false)} (Delayed)",
                                textAlign: TextAlign.end,
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  color: ColorsConstants.defaultBlack,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              )
                            : Container()
                      : Text(
                          Methods.formatDateTime(
                            matchEntity.dateAndTime,
                            addLineBreak: false,
                          ),
                          textAlign: TextAlign.end,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultBlack,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                ],
              ),
              !(DateTime.now().difference(matchEntity.dateAndTime).inSeconds >=
                          0 &&
                      matchEntity.tossWinner != null &&
                      matchEntity.winner == null)
                  ? matchEntity.winner == null
                        ? SecondaryButton(
                            title: "Start Match",
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                Routes.scorerInitialPage,
                                extra: matchEntity,
                              );
                            },
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
                  : Container(
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
                    ),
            ],
          )
        : Row(
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
              DateTime.now().difference(matchEntity.dateAndTime).inSeconds >= 0
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
          );
  }
}
