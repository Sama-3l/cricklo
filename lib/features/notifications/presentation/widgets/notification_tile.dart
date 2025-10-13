import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/notifications/domain/entities/team_notification_entity.dart';
import 'package:cricklo/features/notifications/presentation/blocs/cubits/NotificationCubit/notification_cubit.dart';
import 'package:cricklo/features/notifications/presentation/widgets/match_notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.teamNotificationEntity,
    required this.title,
    required this.id,
    this.notificationType = NotificationType.team,
  });

  final TeamNotificationEntity? teamNotificationEntity;
  final String title;
  final String id;
  final NotificationType notificationType;

  @override
  Widget build(BuildContext context) {
    if (notificationType == NotificationType.match) {
      return MatchNotificationTile();
    } else if (notificationType == NotificationType.match) {
      return MatchNotificationTile();
    }
    final cubit = context.read<NotificationCubit>();
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: ColorsConstants.accentOrange.withValues(
              alpha: 0.2,
            ),
            child: Center(child: Icon(Icons.person, size: 16)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 14,
                  letterSpacing: -0.8,
                ),
              ),
              Text(
                id,
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          Spacer(),
          PrimaryButton(
            disabled: false,
            onPress: () => notificationType == NotificationType.team
                ? cubit.teamInviteAction(teamNotificationEntity!, "accept")
                : {},
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              "Accept",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () => notificationType == NotificationType.team
                ? cubit.teamInviteAction(teamNotificationEntity!, "deny")
                : {},
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.7),
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
