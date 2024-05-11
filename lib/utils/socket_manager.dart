import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:studenthub/utils/auth_provider.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  static io.Socket? _socket; // Make the socket static
  final List<Function(dynamic)> _socketListeners = [];

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  void registerSocketListener(Function(dynamic) callback) {
    _socketListeners.add(callback);
    print('registering socket listener ${_socketListeners.length}');
  }

  void unregisterSocketListener(Function(dynamic) callback) {
    _socketListeners.remove(callback);
    print('unregistering socket listener ${_socketListeners.length}');
  }

  void triggerSocketEvent(dynamic data) {
    _socketListeners.forEach((listener) {
      print('triggering socket event');
      listener(data);
    });
  }

  Future<io.Socket> connectSocket(BuildContext context, int userId) async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    if (_socket == null) {
      _socket = io.io(
        'https://api.studenthub.dev',
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .disableAutoConnect()
            .build(),
      );

      _socket!.connect();
      _socket!.onConnect((data) => print('Connected'));
      _socket!.onDisconnect((data) => print('Disconnected'));

      _socket!.onConnectError((data) => print('connect error: $data'));
      _socket!.onError((data) => print('error: $data'));
      _socket!.on('NOTI_$userId', (data) {
        print(data);
        print(data["notification"]);
        triggerSocketEvent(data);
      });
      _socket!.on('ERROR', (data) => print('ERROR: $data'));

      return _socket!;
    } else {
      print('already exist, reusing');
      return _socket!;
    }
  }

  void disconnectSocket() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.destroy();
      _socket = null;
      print('socket disconnected');
    }
  }
}
