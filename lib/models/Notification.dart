import 'package:studenthub/models/Message.dart';
import 'package:studenthub/models/Proposal.dart';

class NotificationItem {
  final int id;
  final String title;
  final String content;
  final String body;
  final String notifyFlag;
  final String typeNotifyFlag;
  final Proposal? proposal;
  final Message? message;
  final Postman receiver;
  final Postman sender;
  final DateTime createdAt;

  NotificationItem(
      {required this.id,
      required this.title,
      required this.body,
      required this.content,
      required this.notifyFlag,
      required this.typeNotifyFlag,
      this.proposal,
      this.message,
      required this.receiver,
      required this.sender,
      required this.createdAt});

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
        id: json['id'],
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        content: json['content'] ?? '',
        notifyFlag: json['notifyFlag'] ?? 0,
        typeNotifyFlag: json['typeNotifyFlag'] ?? 0,
        proposal: json['proposal'] != null
            ? Proposal.fromJson(json['proposal'])
            : null,
        message:
            json['message'] != null ? Message.fromJson(json['message']) : null,
        receiver: Postman.fromJson(json['receiver']),
        sender: Postman.fromJson(json['sender']),
        createdAt: DateTime.parse(json['createdAt']));
  }
}
