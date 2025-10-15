import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:flutter/material.dart';

class MatchInfoPage extends StatelessWidget {
  final MatchEntity match;

  const MatchInfoPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final teamA = match.teamA;
    final teamB = match.teamB;

    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // 🏏 Team Logos + Names
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTeamInfo(teamA.teamLogo, teamA.name),
                Text(
                  "vs",
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 18,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.6),
                  ),
                ),
                _buildTeamInfo(teamB.teamLogo, teamB.name),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1.2),

            const SizedBox(height: 16),

            // 🧾 Match Details Section
            _buildMatchDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(String? logo, String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(logo!),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 16,
            color: ColorsConstants.defaultBlack,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMatchDetails(BuildContext context) {
    final details = {
      "Match ID": match.matchID,
      "Format": match.matchType.matchType,
      "Ball Type": "Tennis Ball",
      "Playing": "${match.teamA.name} vs ${match.teamB.name}",
      "Venue": match.location.area,
      "Date & Time": "${match.dateAndTime.toLocal()}".split(
        '.',
      )[0], // readable local time
      "Toss Won By": match.tossWinner ?? "TBD",
      "Decided To": match.tossChoice?.name ?? "TBD",
      "Scorer": match.scorer["name"],
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🧭 Left Column — Labels
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details.keys.map((key) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  key,
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.defaultBlack,
                    letterSpacing: -0.5,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(width: 24),

        // 📋 Right Column — Values
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details.values.map((value) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  value.toString(),
                  style: TextStyles.poppinsRegular.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 16,
                    letterSpacing: -0.5,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
