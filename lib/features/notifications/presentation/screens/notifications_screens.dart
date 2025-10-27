import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/notifications/presentation/blocs/cubits/NotificationCubit/notification_cubit.dart';
import 'package:cricklo/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreens extends StatefulWidget {
  const NotificationsScreens({super.key});

  @override
  State<NotificationsScreens> createState() => _NotificationsScreensState();
}

class _NotificationsScreensState extends State<NotificationsScreens> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationCubit>()..init(),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final scorerInvites = state.matchNotifications.where(
            (e) => e.notificationType == NotificationType.scorer,
          );
          final nonScorerInvites = state.matchNotifications.where(
            (e) => e.notificationType == NotificationType.match,
          );
          final tournamentModeratorInvites = state.tournamentInvites.where(
            (e) => e.notificationType == NotificationType.tournamentModerator,
          );
          final tournamentTeamInvites = state.tournamentInvites.where(
            (e) => e.notificationType == NotificationType.tournamentTeam,
          );
          print(tournamentTeamInvites);
          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorsConstants.defaultWhite),
              backgroundColor: ColorsConstants.accentOrange,
              title: Text(
                "Notifications",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
              centerTitle: true,
            ),
            body: state.loading
                ? Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: ColorsConstants.accentOrange,
                      ),
                    ),
                  )
                : state.teamNotifications.isEmpty &&
                      scorerInvites.isEmpty &&
                      nonScorerInvites.isEmpty &&
                      tournamentModeratorInvites.isEmpty &&
                      tournamentTeamInvites.isEmpty
                ? Center(
                    child: Text(
                      "No Notifications",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 24,
                        letterSpacing: -1.2,
                        color: ColorsConstants.accentOrange,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: ListView(
                      children: [
                        // const SizedBox(height: 24),
                        if (state.teamNotifications.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: SectionHeader(
                              title: "Team Invites",
                              showIcon: false,
                            ),
                          ),
                          ...state.teamNotifications.map(
                            (e) => NotificationTile(
                              teamNotificationEntity: e,
                              title: e.teamName,
                              id: e.teamId,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (scorerInvites.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Text(
                              "Scorer Invites",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.accentOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...scorerInvites.map(
                            (e) => NotificationTile(
                              title: "",
                              id: "",
                              matchNotificationEntity: e,
                              notificationType: NotificationType.scorer,
                            ),
                          ),
                        ],
                        if (nonScorerInvites.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Text(
                              "Game Invites",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.accentOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...nonScorerInvites.map(
                            (e) => NotificationTile(
                              title: "",
                              id: "",
                              matchNotificationEntity: e,
                              notificationType: NotificationType.scorer,
                            ),
                          ),
                        ],
                        if (tournamentModeratorInvites.isNotEmpty ||
                            tournamentTeamInvites.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: SectionHeader(
                              title: "Tournament Invites",
                              showIcon: false,
                            ),
                          ),
                        ],
                        if (tournamentModeratorInvites.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Moderator Invites",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.accentOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...tournamentModeratorInvites.map(
                            (e) => NotificationTile(
                              title: e.tournamentName,
                              id: e.tournamentId,
                              tournamentNotificationEntity: e,
                              notificationType: e.notificationType,
                            ),
                          ),
                        ],
                        if (tournamentTeamInvites.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Team Invites",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 16,
                                letterSpacing: -0.8,
                                color: ColorsConstants.accentOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...tournamentTeamInvites.map(
                            (e) => NotificationTile(
                              title: e.tournamentName,
                              id: e.tournamentId,
                              tournamentNotificationEntity: e,
                              notificationType: e.notificationType,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
