import 'package:intl/intl.dart';
import 'package:studenthub/models/MeetingRoom.dart';

class Interview {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int disableFlag;
  final int meetingRoomId;
  final MeetingRoom? meetingRoom;

  Interview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.disableFlag,
    required this.meetingRoomId,
    this.meetingRoom,
  });

  String formattedStartTime() {
    final vietnamTime = startTime.add(const Duration(hours: 7));
    final formatter = DateFormat('HH:mm, dd/MM/yyyy');
    final formattedTime = formatter.format(vietnamTime);
    return formattedTime;
  }

  String formattedEndTime() {
    final vietnamTime = endTime.add(const Duration(hours: 7));
    final formatter = DateFormat('HH:mm, dd/MM/yyyy');
    final formattedTime = formatter.format(vietnamTime);
    return formattedTime;
  }

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      disableFlag: json['disableFlag'],
      meetingRoomId: json['meetingRoomId'],
      meetingRoom: json['meetingRoom'] != null ? MeetingRoom.fromJson(json['meetingRoom']) : null,
    );
  }
}