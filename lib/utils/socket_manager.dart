import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    socket.on('RECEIVE_INTERVIEW', (data) => print(data));
  }

  static void createInterview(String title, String content, DateTime startDate, DateTime endDate, TimeOfDay startTime, TimeOfDay endTime, int projectId, int senderId, int receiverId, String meetingRoomCode, String meetingRoomID) {
    DateTime startDateTime = DateTime(startDate.year, startDate.month, startDate.day, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);

    if (socket.connected) {
      socket.emit('SCHEDULE_INTERVIEW', {
        'title': title,
        'content': content,
        'startTime': startDateTime.toIso8601String(),
        'endTime': endDateTime.toIso8601String(),
        'projectId': projectId,
        'senderId': senderId,
        'receiverId': receiverId,
        'meeting_room_code': meetingRoomCode,
        'meeting_room_id': meetingRoomID
      });
    } else {
      print('Socket is not connected');
    }
  }

  static void updateInterview(int interviewId, int projectId, int senderId, int receiverId, String title, DateTime startDate, DateTime endDate, TimeOfDay startTime, TimeOfDay endTime, bool updateAction) {
    DateTime startDateTime = DateTime(startDate.year, startDate.month, startDate.day, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);

    if (socket.connected) {
      socket.emit('UPDATE_INTERVIEW', {
        'interviewId': interviewId,
        'senderId': senderId,
        'receiverId': receiverId,
        'projectId': projectId,
        'title': title,
        'startTime': startDateTime.toIso8601String(),
        'endTime': endDateTime.toIso8601String(),
        'updateAction': updateAction
      });
    } else {
      print('Socket is not connected');
    }
  }

  static void cancelInterview(int interviewId, int projectId, int senderId, int receiverId, bool deleteAction) {

    if (socket.connected) {
      socket.emit('UPDATE_INTERVIEW', {
        'interviewId': interviewId,
        'senderId': senderId,
        'receiverId': receiverId,
        'projectId': projectId,
        'deleteAction': deleteAction,
      });
    } else {
      print('Socket is not connected');
    }
  }
}