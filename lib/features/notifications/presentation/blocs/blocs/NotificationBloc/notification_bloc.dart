import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/stream_usecase.dart';
import 'package:cricklo/features/notifications/data/usecases/get_notification_usecase.dart';
import 'package:flutter/material.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final GlobalKey<NavigatorState> navigatorKey;
  late final StreamSubscription _sub;

  NotificationBloc(this.getNotificationsUseCase, this.navigatorKey)
    : super(const NotificationInitial(unreadCount: 0)) {
    // listen to incoming notifications from the UseCase stream
    _sub = getNotificationsUseCase(NoParams()).listen((either) {
      either.fold(
        (failure) {
          print("⚠️ Notification stream error: ${failure.message}");
        },
        (notification) {
          add(NotificationReceived());
          // Optional: show ScaffoldMessenger directly
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(notification['message'] ?? "New Notification"),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      );
    });

    on<NotificationReceived>((event, emit) {
      emit(state.copyWith(unreadCount: state.unreadCount + 1));
    });

    on<NotificationReadAll>((event, emit) {
      emit(state.copyWith(unreadCount: 0));
    });
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
