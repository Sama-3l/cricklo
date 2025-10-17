import 'dart:async';

import 'package:cricklo/features/mainapp/domain/repo/socket_auth_repo.dart';
import 'package:cricklo/features/scorer/domain/models/remote/broadcast_wrapper_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get_it/get_it.dart';

class SocketService {
  IO.Socket? socket;
  IO.Socket? matchSocket;
  final _authRepository = GetIt.instance<IAuthRepository>();

  bool get isConnected => socket?.connected ?? false;

  /// Connect to /notify namespace with token from CookieJar
  Future<void> connect() async {
    final token = await _authRepository.getAuthToken();
    if (token == null) {
      print("⚠️ Cannot connect — missing auth token");
      return;
    }

    // Namespace included directly in URL
    socket = IO.io(
      'https://cricklo.onrender.com/api/v1/notify',
      IO.OptionBuilder()
          .setTransports(['websocket']) // Flutter requires this
          .setExtraHeaders({'cookie': 'token=$token'}) // send JWT as cookie
          .enableAutoConnect()
          .enableForceNew()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .setPath('/socket.io') // must match server path
          .build(),
    );

    // Socket event listeners
    socket!.onConnect((_) => print('🟢 Connected to /notify'));
    socket!.onDisconnect(
      (reason) => print('🔴 Disconnected from /notify: $reason'),
    );
    socket!.onConnectError((err) => print('❌ Socket connect error: $err'));
    socket!.onReconnectAttempt(
      (attempt) => print('🔄 Reconnect attempt $attempt'),
    );

    // Listen to in-app notifications
    socket!.on('notification:new', (data) {
      print('📩 New notification: $data');
      // TODO: forward to Cubit / Stream for UI
    });

    // Connect socket
    socket!.connect();
  }

  /// Emit events to backend if needed
  void emit(String event, dynamic data) {
    if (socket != null && socket!.connected) {
      socket!.emit(event, data);
    } else {
      print('⚠️ Cannot emit, socket not connected');
    }
  }

  /// Connect to match room
  void connectToMatchRoom(String matchId) {
    matchSocket = IO.io(
      'https://cricklo.onrender.com/match',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'matchId': matchId})
          .enableAutoConnect()
          .enableForceNew()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .build(),
    );

    matchSocket!.onConnect((_) {
      print('Connected to match room: $matchId');
    });

    matchSocket!.onDisconnect((_) {
      print('Disconnected from match room');
    });

    matchSocket!.onError((data) {
      print('matchSocket error: $data');
    });
    matchSocket!.connect();
  }

  Stream<BroadcastWrapperModel> listenToMatchStream() async* {
    final controller = StreamController<BroadcastWrapperModel>();

    matchSocket?.on('match_broadcast', (data) {
      try {
        final model = BroadcastWrapperModel.fromJson(data);
        controller.add(model);
      } catch (e) {
        print("Failed to parse broadcast: $e");
      }
    });

    yield* controller.stream;
  }

  void disconnect() {
    socket?.disconnect();
    socket?.destroy();
    matchSocket?.disconnect();
    matchSocket?.destroy();
    print('🔴 Socket manually disconnected');
  }
}
