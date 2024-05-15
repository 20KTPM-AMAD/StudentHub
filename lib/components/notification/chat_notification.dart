import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/chat/message_detail_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';

class ChatNotificationCard extends StatefulWidget {
  final NotificationItem notification;
  const ChatNotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  ChatNotificationCardState createState() => ChatNotificationCardState();
}

class ChatNotificationCardState extends State<ChatNotificationCard> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> readNoti() async {
    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        final response = await http.patch(
          Uri.parse('https://api.studenthub.dev/api/notification/readNoti/${widget.notification.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.notification.notifyFlag == "0" ? Colors.green.shade200 : Colors.green.shade50,
      margin: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {

        },
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/chat.png',
                      fit: BoxFit.cover, width: 50, height: 50),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.notification.sender.fullname,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // Số dòng tối đa
                        ),
                        Text(
                          widget.notification.message != null
                              ? widget.notification.message!.content
                              : 'Message content',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // Số dòng tối đa
                        ),
                        Text(
                          widget.notification.message != null
                              ? widget.notification.message!
                              .formattedCreatedAt()
                              : DateFormat('HH:mm, dd/MM/yyyy').format(
                              DateTime.now().add(const Duration(hours: 7))),
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            readNoti();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MessageDetailScreen(
                      personID: widget.notification.sender.id,
                      personFullName: widget.notification.sender.fullname,
                      projectID: widget.notification.message!.projectId!
                  )
              ),
            );
          },
        ),
      ),
    );
  }
}