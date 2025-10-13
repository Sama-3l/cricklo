import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduledMatchesItem extends StatelessWidget {
  const ScheduledMatchesItem({super.key, required this.match});

  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: ColorsConstants.defaultWhite,
                  border: Border.all(color: ColorsConstants.defaultBlack),
                ),
                height: 64,
                width: 64,
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: CachedNetworkImageProvider(
                    match.teamA.teamLogo,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(32, 0),
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: ColorsConstants.defaultWhite,
                    border: Border.all(color: ColorsConstants.defaultBlack),
                  ),

                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: CachedNetworkImageProvider(
                      match.teamB.teamLogo,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                match.teamA.name,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                match.teamB.name,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                ),
              ),
              // const Spacer(),
              Text(
                Methods.formatDateTime(match.dateAndTime, addLineBreak: false),
                style: TextStyles.poppinsRegular.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
