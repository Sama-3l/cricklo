import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class ScorerTeamHeaderItem extends StatelessWidget {
  const ScorerTeamHeaderItem({
    super.key,
    required this.teamId,
    required this.teamLogo,
    required this.teamName,
    this.inviteAccepted = true,
  });

  final String teamName;
  final String teamLogo;
  final String teamId;
  final bool inviteAccepted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          inviteAccepted ? "INVITE ACCEPTED" : "INVITE PENDING",
          style: TextStyles.poppinsLight.copyWith(
            fontSize: 12,
            letterSpacing: 1,
            color: ColorsConstants.defaultBlack,
          ),
        ),
        const SizedBox(height: 8),
        CircleAvatar(
          radius: 40,
          backgroundColor: ColorsConstants.accentOrange.withValues(alpha: 0.2),
          child: Icon(
            Icons.people,
            size: 24,
            color: ColorsConstants.defaultBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          teamName,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.poppinsSemiBold.copyWith(
            color: ColorsConstants.defaultBlack,
            fontSize: 10,
            letterSpacing: -0.2,
          ),
        ),
        Text(
          teamId,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 12,
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
