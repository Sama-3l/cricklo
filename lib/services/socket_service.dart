import 'package:cricklo/features/mainapp/domain/repo/socket_auth_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get_it/get_it.dart';

class SocketService {
  IO.Socket? socket;
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

  /// Disconnect socket manually
  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
      socket = null;
      print('🔴 Socket manually disconnected');
    }
  }

  /// Emit events to backend if needed
  void emit(String event, dynamic data) {
    if (socket != null && socket!.connected) {
      socket!.emit(event, data);
    } else {
      print('⚠️ Cannot emit, socket not connected');
    }
  }
}
