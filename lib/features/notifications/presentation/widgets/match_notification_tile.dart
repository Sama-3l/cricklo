import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/notifications/domain/entities/match_notification_entity.dart';
import 'package:cricklo/features/notifications/presentation/blocs/cubits/NotificationCubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchNotificationTile extends StatelessWidget {
  const MatchNotificationTile({
    super.key,
    required this.matchNotificationEntity,
  });

  final MatchNotificationEntity matchNotificationEntity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorsConstants.onSurfaceGrey,
      ),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Top row: Team images + VS + LIVE
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${matchNotificationEntity.format.matchType} Match",
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 12,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                Text(
                  Methods.formatDateTime(
                    matchNotificationEntity.dateTime,
                    addLineBreak: false,
                  ),
                  style: TextStyles.poppinsSemiBold.copyWith(
                    color: ColorsConstants.defaultBlack,
                    fontSize: 10,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Team 1
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                          matchNotificationEntity.teamA.logo,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          matchNotificationEntity.teamA.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "VS",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          matchNotificationEntity.teamB.name,
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                          matchNotificationEntity.teamB.logo,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "${matchNotificationEntity.locationEntity.location}, ${matchNotificationEntity.locationEntity.area}, ${matchNotificationEntity.locationEntity.city}, ${matchNotificationEntity.locationEntity.state}",
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 10,
                letterSpacing: -0.2,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    disabled: false,
                    onPress: () => cubit.matchInviteAction(
                      matchNotificationEntity,
                      "accept",
                    ),
                    noShadow: true,
                    child: Text(
                      "Accept",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultWhite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    disabled: false,
                    onPress: () => cubit.matchInviteAction(
                      matchNotificationEntity,
                      "deny",
                    ),
                    color: ColorsConstants.surfaceOrange,
                    noShadow: true,
                    child: Text(
                      "Deny",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.5,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
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
