import 'package:intl/intl.dart';
import 'package:studenthub/models/Interview.dart';
import 'package:studenthub/models/Project.dart';

class Message {
  final int id;
  final DateTime createdAt;
  final String content;
  final Postman sender;
  final Postman receiver;
  final Project? project;
  final Interview? interview;

  Message({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.sender,
    required this.receiver,
    this.project,
    this.interview,
  });

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
    final interview = interviewJson != null ? Interview.fromJson(interviewJson) : null;

    return Message(
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      content: json['content'] ?? '',
      sender: Postman.fromJson(json['sender'] ?? {}),
      receiver: Postman.fromJson(json['receiver'] ?? {}),
      project: json['project'] != null ? Project.fromJson(json['project']) : null,
      interview: interview,
    );
  }
}

class Postman {
  final int id;
  final String fullname;

  Postman({required this.id, required this.fullname});

  factory Postman.fromJson(Map<String, dynamic> json) {
    return Postman(
      id: json['id'],
      fullname: json['fullname'],
    );
  }
}
