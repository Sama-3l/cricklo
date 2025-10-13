import 'dart:async';

import 'package:cricklo/features/notifications/domain/models/remote/get_notifications_response_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/team_invite_response_response_model.dart';
import 'package:cricklo/services/api_service.dart';
import 'package:cricklo/services/socket_service.dart';

abstract class NotificationRemoteDataSource {
  Stream<Map<String, dynamic>> getNotificationStream();
  Future<GetNotificationsResponseModel> getNotifications();
  Future<TeamInviteResponseResponseModel> respondToTeamInvite(
    String teamId,
    String inviteId,
    String action,
  );
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final SocketService socketService;
  final ApiService _apiService;

  NotificationRemoteDataSourceImpl(
    this._apiService, {
    required this.socketService,
  });

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

  @override
  Future<GetNotificationsResponseModel> getNotifications() {
    return _apiService.getNotifications();
  }

  @override
  Future<TeamInviteResponseResponseModel> respondToTeamInvite(
    String teamId,
    String inviteId,
    String action,
  ) {
    return _apiService.teamInviteResponse(teamId, inviteId, {"action": action});
  }
}
