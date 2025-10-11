import 'package:cricklo/features/mainapp/domain/repo/socket_auth_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get_it/get_it.dart';

class SocketService {
  IO.Socket? _socket;
  final _authRepository = GetIt.instance<IAuthRepository>();

  bool get isConnected => _socket?.connected ?? false;

  /// Connect to /notify namespace with token from CookieJar
  Future<void> connect() async {
    final token = await _authRepository.getAuthToken();
    if (token == null) {
      print("⚠️ Cannot connect — missing auth token");
      return;
    }

    // Namespace included directly in URL
    _socket = IO.io(
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
    _socket!.onConnect((_) => print('🟢 Connected to /notify'));
    _socket!.onDisconnect(
      (reason) => print('🔴 Disconnected from /notify: $reason'),
    );
    _socket!.onConnectError((err) => print('❌ Socket connect error: $err'));
    _socket!.onReconnectAttempt(
      (attempt) => print('🔄 Reconnect attempt $attempt'),
    );

    // Listen to in-app notifications
    _socket!.on('notification:new', (data) {
      print('📩 New notification: $data');
      // TODO: forward to Cubit / Stream for UI
    });

    // Connect socket
    _socket!.connect();
  }

  /// Disconnect socket manually
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      print('🔴 Socket manually disconnected');
    }
  }

  /// Emit events to backend if needed
  void emit(String event, dynamic data) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit(event, data);
    } else {
      print('⚠️ Cannot emit, socket not connected');
    }
  }
}
