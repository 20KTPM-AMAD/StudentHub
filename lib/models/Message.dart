import 'package:intl/intl.dart';
import 'package:studenthub/models/Interview.dart';
import 'package:studenthub/models/Project.dart';

class Message {
  final int id;
  final DateTime createdAt;
  final String content;
  late Postman sender;
  late Postman receiver;
  final Project? project;
  final Interview? interview;
  final SubNotifications? notifications;
  final int? projectId;

  Message(
      {required this.id,
      required this.createdAt,
      required this.content,
      required this.sender,
      required this.receiver,
      this.project,
      this.interview,
      this.notifications,
      this.projectId});

  String formattedCreatedAt() {
    final vietnamTime = createdAt.add(const Duration(hours: 7));
    final formatter = DateFormat('HH:mm, dd/MM/yyyy');
    final formattedTime = formatter.format(vietnamTime);
    return formattedTime;
  }

  factory Message.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Invalid JSON format');
    }

    final interviewJson = json['interview'];
    final interview =
        interviewJson != null ? Interview.fromJson(interviewJson) : null;

    final notificaitonsJson = json['notifications'];
    final notifications = notificaitonsJson != null
        ? SubNotifications.fromJson(notificaitonsJson)
        : null;
    return Message(
        id: json['id'] ?? 0,
        createdAt: DateTime.parse(json['createdAt'] ?? ''),
        content: json['content'] ?? '',
        sender: Postman.fromJson(json['sender'] ?? {}),
        receiver: Postman.fromJson(json['receiver'] ?? {}),
        project:
            json['project'] != null ? Project.fromJson(json['project']) : null,
        interview: interview,
        notifications: notifications,
        projectId: json['projectId']);
  }
}

class Postman {
  final int id;
  final String fullname;

  Postman({required this.id, required this.fullname});

  factory Postman.fromJson(Map<String, dynamic> json) {
    return Postman(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? 'Full name',
    );
  }
}

class SubNotifications {
  final int id;
  final String notifyFlag;

  SubNotifications({required this.id, required this.notifyFlag});

  factory SubNotifications.fromJson(Map<String, dynamic> json) {
    return SubNotifications(
      id: json['id'],
      notifyFlag: json['notifyFlag'],
    );
  }
}
