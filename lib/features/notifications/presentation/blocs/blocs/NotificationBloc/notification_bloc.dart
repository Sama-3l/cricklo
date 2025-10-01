import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final Stream<void> notificationStream;
  late final StreamSubscription _sub;

  NotificationBloc(this.notificationStream)
    : super(const NotificationInitial(unreadCount: 5)) {
    // listen to incoming notifications
    _sub = notificationStream.listen((_) {
      add(NotificationReceived());
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
