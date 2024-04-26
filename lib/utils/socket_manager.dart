import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'auth_provider.dart';


class SocketManager {
  static late io.Socket socket;

  static void initializeSocket(BuildContext context, int projectId) {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    socket = io.io(
      'https://api.studenthub.dev',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };
    socket.io.options?['query'] = {
      'project_id': projectId.toString(),
    };
    socket.connect();
    socket.onConnect((data) => print('Connected'));
    socket.onDisconnect((data) => print('Disconnected'));

    socket.onConnectError((data) => print(data));
    socket.onError((data) => print(data));
    socket.on('RECEIVE_MESSAGE', (data) => print(data));
    socket.on('ERROR', (data) => print(data));
  }

  static void sendMessage(String message, int projectId, int senderId, int receiverId) {
    if (socket.connected) {
      socket.emit('SEND_MESSAGE', {
        'content': message,
        'projectId': projectId,
        'senderId': senderId,
        'receiverId': receiverId,
        'messageFlag': 0,
      });
    } else {
      print('Socket is not connected');
    }
  }
}