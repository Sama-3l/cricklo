part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {
  final bool loading;
  final List<TeamNotificationEntity> teamNotifications;

  const NotificationState({
    required this.loading,
    required this.teamNotifications,
  });
}

final class NotificationUpdate extends NotificationState {
  const NotificationUpdate({
    required super.loading,
    required super.teamNotifications,
  });
}
