import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/chat/message_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
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
                            ? widget.notification.message!.formattedCreatedAt()
                            : DateFormat('HH:mm, dd/MM/yyyy').format(
                                DateTime.now().add(const Duration(hours: 7))),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessageDetailScreen(
                                    personID: widget.notification.sender.id,
                                    personFullName:
                                        widget.notification.sender.fullname,
                                    projectID: widget
                                        .notification.message!.projectId!)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.white),
                        child: Text(AppLocalizations.of(context)!.view,
                            style: const TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
