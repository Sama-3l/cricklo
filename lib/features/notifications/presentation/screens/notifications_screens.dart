import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:flutter/material.dart';

class NotificationsScreens extends StatefulWidget {
  const NotificationsScreens({super.key});

  @override
  State<NotificationsScreens> createState() => _NotificationsScreensState();
}

class _NotificationsScreensState extends State<NotificationsScreens> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SectionHeader(title: "Team Invites", showIcon: false),
            ),
            NotificationTile(title: "Mumbai Masters", id: "mumbaimasters-001"),
            NotificationTile(title: "Mumbai Masters", id: "mumbaimasters-001"),
            NotificationTile(title: "Mumbai Masters", id: "mumbaimasters-001"),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SectionHeader(title: "Match Invites", showIcon: false),
            ),
            const SizedBox(height: 8),
            Text(
              "Scorer Invites",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.accentOrange,
              ),
            ),
            const SizedBox(height: 6),
            NotificationTile(
              title: "Mumbai Masters",
              id: "mumbaimasters-001",
              notificationType: NotificationType.match,
            ),
            NotificationTile(
              title: "Mumbai Masters",
              id: "mumbaimasters-001",
              notificationType: NotificationType.match,
            ),
            NotificationTile(
              title: "Mumbai Masters",
              id: "mumbaimasters-001",
              notificationType: NotificationType.match,
            ),
            const SizedBox(height: 12),
            Text(
              "Game Invites",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.accentOrange,
              ),
            ),
            NotificationTile(
              title: "Mumbai Masters",
              id: "mumbaimasters-001",
              notificationType: NotificationType.match,
            ),
            NotificationTile(
              title: "Mumbai Masters",
              id: "mumbaimasters-001",
              notificationType: NotificationType.match,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SectionHeader(
                title: "Tournament Invites",
                showIcon: false,
              ),
            ),
            NotificationTile(title: "Mumbai Masters", id: "mumbaimasters-001"),
          ],
        ),
      ),
    );
  }
}
