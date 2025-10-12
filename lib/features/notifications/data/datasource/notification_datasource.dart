import 'dart:async';

import 'package:cricklo/services/socket_service.dart';

abstract class NotificationRemoteDataSource {
  Stream<Map<String, dynamic>> getNotificationStream();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final SocketService socketService;

  NotificationRemoteDataSourceImpl({required this.socketService});

  @override
  Stream<Map<String, dynamic>> getNotificationStream() {
    final controller = StreamController<Map<String, dynamic>>();

    socketService.socket?.on('notification:new', (data) {
      if (data is Map<String, dynamic>) {
        print(data);
        controller.add(data);
      }
    });

    return controller.stream;
  }
}
