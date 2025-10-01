part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {
  final int unreadCount;
  const NotificationState({required this.unreadCount});

  NotificationState copyWith({int? unreadCount}) =>
      NotificationUpdate(unreadCount: unreadCount ?? this.unreadCount);
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial({required super.unreadCount});
}

final class NotificationUpdate extends NotificationState {
  const NotificationUpdate({required super.unreadCount});
}
