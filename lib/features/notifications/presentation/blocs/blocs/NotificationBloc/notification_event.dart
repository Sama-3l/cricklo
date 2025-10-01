part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class NotificationReceived extends NotificationEvent {}

class NotificationReadAll extends NotificationEvent {}
