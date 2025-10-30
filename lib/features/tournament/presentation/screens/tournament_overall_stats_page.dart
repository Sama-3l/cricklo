import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:flutter/material.dart';

class OverallStatsPage extends StatelessWidget {
  const OverallStatsPage({super.key, required this.tournamentEntity});

  final TournamentEntity tournamentEntity;

  @override
  Widget build(BuildContext context) {
    final highlights = Methods.computeTournamentHighlights(
      battingStats: tournamentEntity.battingStats,
      bowlingStats: tournamentEntity.bowlingStats,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          childAspectRatio: 0.8,
        ),
        itemCount: highlights.length,
        itemBuilder: (context, index) {
          final stat = highlights[index];
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsConstants.onSurfaceGrey,
              boxShadow: [
                BoxShadow(
                  color: ColorsConstants.defaultBlack.withValues(alpha: 0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: ColorsConstants.surfaceOrange,
                  backgroundImage: CachedNetworkImageProvider(stat.logo),
                ),
                const SizedBox(height: 16),
                Text(
                  "${stat.value}",
                  style: TextStyles.poppinsBold.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 24,
                    letterSpacing: -1.2,
                  ),
                ),
                Text(
                  stat.title,
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 12,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat.playerName,
                  style: TextStyles.poppinsBold.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                ),
                if (stat.teamName.isNotEmpty)
                  Text(
                    stat.teamName.toUpperCase(),
                    style: TextStyles.poppinsSemiBold.copyWith(
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
