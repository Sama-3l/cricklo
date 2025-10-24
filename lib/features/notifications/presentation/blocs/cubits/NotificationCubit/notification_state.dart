part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {
  final bool loading;
  final List<TeamNotificationEntity> teamNotifications;
  final List<MatchNotificationEntity> matchNotifications;
  final List<TournamentNotificationEntity> tournamentInvites;

  const NotificationState({
    required this.loading,
    required this.teamNotifications,
    required this.matchNotifications,
    required this.tournamentInvites,
  });
}

final class NotificationUpdate extends NotificationState {
  const NotificationUpdate({
    required super.loading,
    required super.teamNotifications,
    required super.matchNotifications,
    required super.tournamentInvites,
  });
}
