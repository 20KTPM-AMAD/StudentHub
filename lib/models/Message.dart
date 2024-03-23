import 'package:studenthub/models/ScheduleInterview.dart';

class Message {
  String senderUid;
  String receiverUid;
  String type;
  String? message;
  ScheduleInterview? scheduleInterview;
  DateTime timestamp;

  Message(
      {required this.senderUid,
        required this.receiverUid,
        required this.type,
        this.message,
        this.scheduleInterview,
        required this.timestamp});

  Map toMap() {
    var map = <String, dynamic>{};
    map['senderUid'] = senderUid;
    map['receiverUid'] = receiverUid;
    map['type'] = type;
    map['message'] = message;
    map['scheduleInterview'] = scheduleInterview;
    map['timestamp'] = timestamp;
    return map;
  }

  Message fromMap(Map<String, dynamic> map) {
    Message message = Message(
        senderUid: map['senderUid'],
        receiverUid: map['receiverUid'],
        type: map['type'],
        message: map['message'],
        scheduleInterview: map['scheduleInterview'],
        timestamp: map['timestamp']);
    return message;
  }
}