import 'package:intl/intl.dart';
import 'package:studenthub/models/Project.dart';

class Message {
  final int id;
  final DateTime createdAt;
  final String content;
  final Postman sender;
  final Postman receiver;
  final Project? project;

  Message({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.sender,
    required this.receiver,
    this.project,
  });

  String formattedCreatedAt() {
    final formatter = DateFormat('HH:mm, dd/MM/yyyy');
    return formatter.format(createdAt);
  }

  factory Message.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Invalid JSON format');
    }

    return Message(
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      content: json['content'] ?? '',
      sender: Postman.fromJson(json['sender'] ?? {}),
      receiver: Postman.fromJson(json['receiver'] ?? {}),
      project: json['project'] != null ? Project.fromJson(json['project']) : null,
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
