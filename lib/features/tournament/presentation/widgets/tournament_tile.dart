import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TournamentTile extends StatelessWidget {
  const TournamentTile({
    super.key,
    required this.tournamentEntity,
    this.whiteColor = true,
  });

  final TournamentEntity tournamentEntity;
  final bool whiteColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(
        context,
      ).push(Routes.tournamentPage, extra: tournamentEntity),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
          color: whiteColor
              ? ColorsConstants.defaultWhite
              : ColorsConstants.onSurfaceGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top row: Team images + VS + LIVE
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: tournamentEntity.banner,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          tournamentEntity.name,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 20,
                            letterSpacing: -1,
                            color: ColorsConstants.defaultBlack,
                            height: 1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Invitation Deadline:",
                            style: TextStyles.poppinsMedium.copyWith(
                              fontSize: 12,
                              letterSpacing: -0.5,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                          Text(
                            Methods.getFormattedDate(
                              tournamentEntity.inviteDeadline,
                            ),
                            style: TextStyles.poppinsBold.copyWith(
                              fontSize: 12,
                              letterSpacing: -0.5,
                              color: ColorsConstants.defaultBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Methods.getDateRangeFormatted(
                          tournamentEntity.startDate,
                          tournamentEntity.endDate,
                        ),
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            width: 1,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${tournamentEntity.spotsLeft}",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  color: ColorsConstants.defaultBlack,
                                  fontSize: 16,
                                  letterSpacing: -0.8,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "/ ${tournamentEntity.maxTeams} spots left",
                                style: TextStyles.poppinsMedium.copyWith(
                                  color: ColorsConstants.defaultBlack,
                                  fontSize: 12,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
