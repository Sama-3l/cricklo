import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchTileHeader extends StatelessWidget {
  const MatchTileHeader({
    super.key,
    required this.matchEntity,
    required this.dateSet,
  });

  final MatchEntity matchEntity;
  final bool dateSet;

  @override
  Widget build(BuildContext context) {
    return GlobalVariables.user != null &&
            matchEntity.scorer["profileId"] == GlobalVariables.user!.profileId
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${matchEntity.matchCategory.title} Match",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.5,
                          ),
                          letterSpacing: -0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: CircleAvatar(
                          backgroundColor: ColorsConstants.defaultBlack
                              .withValues(alpha: 0.5),
                          radius: 2,
                        ),
                      ),
                      Text(
                        matchEntity.tournamentName.isNotEmpty &&
                                matchEntity.matchStatus != MatchStatus.completed
                            ? Methods.abbreviateTeamName(
                                matchEntity.tournamentName,
                              )
                            : matchEntity.matchType.matchType,
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.5,
                          ),
                          letterSpacing: -0.5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  matchEntity.matchStatus == MatchStatus.upcoming ||
                          matchEntity.matchStatus == MatchStatus.ongoing
                      ? Text(
                          dateSet
                              ? "${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: false)} ${DateTime.now().difference(matchEntity.dateAndTime).inSeconds >= 0 && matchEntity.matchStatus != MatchStatus.ongoing ? "(Delayed)" : ""}"
                              : "Not Scheduled",
                          textAlign: TextAlign.end,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultBlack,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        )
                      : matchEntity.matchStatus == MatchStatus.completed
                      ? Text(
                          Methods.abbreviateTeamName(
                            matchEntity.tournamentName,
                          ),
                          textAlign: TextAlign.end,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            color: ColorsConstants.defaultBlack,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        )
                      : Container(),
                ],
              ),
              matchEntity.matchStatus == MatchStatus.upcoming
                  ? SecondaryButton(
                      title: "Start Match",
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          Routes.scorerInitialPage,
                          extra: matchEntity,
                        );
                      },
                    )
                  : matchEntity.matchStatus == MatchStatus.ongoing
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
                      dateSet
                          ? "${DateTime.now().difference(matchEntity.dateAndTime).inSeconds >= 0 && matchEntity.matchStatus != MatchStatus.completed ? "(Delayed)\n" : ""}${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: false)}"
                          : "Not Scheduled",
                      textAlign: TextAlign.end,
                      style: TextStyles.poppinsSemiBold.copyWith(
                        color: ColorsConstants.defaultBlack,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${matchEntity.matchCategory.title} Match",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    Methods.abbreviateTeamName(matchEntity.tournamentName),
                    textAlign: TextAlign.end,
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultBlack,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              matchEntity.matchStatus == MatchStatus.upcoming ||
                      matchEntity.matchStatus == MatchStatus.completed
                  ? Text(
                      dateSet
                          ? "${DateTime.now().difference(matchEntity.dateAndTime).inSeconds >= 0 && matchEntity.matchStatus != MatchStatus.completed ? "(Delayed)\n" : ""}${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: matchEntity.matchStatus == MatchStatus.completed)}"
                          : "Not Scheduled",
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
          );

    // @override
    // Widget build(BuildContext context) {
    //   return GlobalVariables.user != null &&
    //           matchEntity.scorer["profileId"] == GlobalVariables.user!.profileId
    //       ? Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "${matchEntity.matchCategory.title} Match",
    //                   style: TextStyles.poppinsMedium.copyWith(
    //                     fontSize: 12,
    //                     color: ColorsConstants.defaultBlack.withValues(
    //                       alpha: 0.5,
    //                     ),
    //                     letterSpacing: -0.5,
    //                   ),
    //                 ),
    //                 DateTime.now()
    //                             .difference(matchEntity.dateAndTime)
    //                             .inSeconds >=
    //                         0
    //                     ? matchEntity.tossWinner == null
    //                           ? Text(
    //                               dateSet
    //                                   ? "${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: false)} (Delayed)"
    //                                   : "Not Scheduled",
    //                               textAlign: TextAlign.end,
    //                               style: TextStyles.poppinsSemiBold.copyWith(
    //                                 color: ColorsConstants.defaultBlack,
    //                                 fontSize: 12,
    //                                 letterSpacing: 0.5,
    //                               ),
    //                             )
    //                           : Container()
    //                     : Text(
    //                         "", // ADD TOURNAMENT DETAILS HERE
    //                         textAlign: TextAlign.end,
    //                         style: TextStyles.poppinsSemiBold.copyWith(
    //                           color: ColorsConstants.defaultBlack,
    //                           fontSize: 12,
    //                           letterSpacing: 0.5,
    //                         ),
    //                       ),
    //               ],
    //             ),
    //             !(DateTime.now().difference(matchEntity.dateAndTime).inSeconds >=
    //                         0 &&
    //                     matchEntity.tossWinner != null &&
    //                     matchEntity.winner == null)
    //                 ? matchEntity.winner == null
    //                       ? matchEntity.draw
    //                             ? Text(
    //                                 dateSet
    //                                     ? Methods.formatDateTime(
    //                                         matchEntity.dateAndTime,
    //                                       )
    //                                     : "Not Scheduled",
    //                                 textAlign: TextAlign.end,
    //                                 style: TextStyles.poppinsSemiBold.copyWith(
    //                                   color: ColorsConstants.defaultBlack,
    //                                   fontSize: 12,
    //                                   letterSpacing: 0.5,
    //                                 ),
    //                               )
    //                             : SecondaryButton(
    //                                 title: "Start Match",
    //                                 onTap: () {
    //                                   GoRouter.of(context).pushNamed(
    //                                     Routes.scorerInitialPage,
    //                                     extra: matchEntity,
    //                                   );
    //                                 },
    //                               )
    //                       : Text(
    //                           dateSet
    //                               ? Methods.formatDateTime(
    //                                   matchEntity.dateAndTime,
    //                                 )
    //                               : "Not Scheduled",
    //                           textAlign: TextAlign.end,
    //                           style: TextStyles.poppinsSemiBold.copyWith(
    //                             color: ColorsConstants.defaultBlack,
    //                             fontSize: 12,
    //                             letterSpacing: 0.5,
    //                           ),
    //                         )
    //                 : Container(
    //                     padding: const EdgeInsets.symmetric(
    //                       horizontal: 16,
    //                       vertical: 8,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       color: ColorsConstants.warningRed,
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     child: Text(
    //                       "LIVE",
    //                       style: TextStyles.poppinsSemiBold.copyWith(
    //                         color: ColorsConstants.defaultWhite,
    //                         fontSize: 12,
    //                         letterSpacing: 0.5,
    //                       ),
    //                     ),
    //                   ),
    //           ],
    //         )
    //       : Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "${matchEntity.matchCategory.title} Match",
    //               style: TextStyles.poppinsMedium.copyWith(
    //                 fontSize: 12,
    //                 color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
    //                 letterSpacing: -0.5,
    //               ),
    //             ),
    //             DateTime.now().difference(matchEntity.dateAndTime).inSeconds >= 0
    //                 ? matchEntity.tossWinner == null
    //                       ? Text(
    //                           dateSet
    //                               ? "(Delayed)\n${Methods.formatDateTime(matchEntity.dateAndTime, addLineBreak: false)}"
    //                               : "Not Scheduled",
    //                           textAlign: TextAlign.end,
    //                           style: TextStyles.poppinsSemiBold.copyWith(
    //                             color: ColorsConstants.defaultBlack,
    //                             fontSize: 12,
    //                             letterSpacing: 0.5,
    //                           ),
    //                         )
    //                       : matchEntity.winner == null || !matchEntity.draw
    //                       ? Container(
    //                           padding: const EdgeInsets.symmetric(
    //                             horizontal: 16,
    //                             vertical: 8,
    //                           ),
    //                           decoration: BoxDecoration(
    //                             color: ColorsConstants.warningRed,
    //                             borderRadius: BorderRadius.circular(8),
    //                           ),
    //                           child: Text(
    //                             "LIVE",
    //                             style: TextStyles.poppinsSemiBold.copyWith(
    //                               color: ColorsConstants.defaultWhite,
    //                               fontSize: 12,
    //                               letterSpacing: 0.5,
    //                             ),
    //                           ),
    //                         )
    //                       : Text(
    //                           dateSet
    //                               ? Methods.formatDateTime(
    //                                   matchEntity.dateAndTime,
    //                                 )
    //                               : "Not Scheduled",
    //                           textAlign: TextAlign.end,
    //                           style: TextStyles.poppinsSemiBold.copyWith(
    //                             color: ColorsConstants.defaultBlack,
    //                             fontSize: 12,
    //                             letterSpacing: 0.5,
    //                           ),
    //                         )
    //                 : Text(
    //                     dateSet
    //                         ? Methods.formatDateTime(matchEntity.dateAndTime)
    //                         : "Not Scheduled",
    //                     textAlign: TextAlign.end,
    //                     style: TextStyles.poppinsSemiBold.copyWith(
    //                       color: ColorsConstants.defaultBlack,
    //                       fontSize: 12,
    //                       letterSpacing: 0.5,
    //                     ),
    //                   ),
    //           ],
    //         );
  }
}
