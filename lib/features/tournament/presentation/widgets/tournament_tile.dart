import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:flutter/material.dart';

class TournamentTile extends StatelessWidget {
  const TournamentTile({super.key, required this.tournamentEntity});

  final TournamentEntity tournamentEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
        color: ColorsConstants.defaultWhite,
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
                fit: BoxFit.fitWidth,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello World where are you old friend",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 20,
                              letterSpacing: -1,
                              color: ColorsConstants.defaultBlack,
                              height: 1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
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
                        ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
