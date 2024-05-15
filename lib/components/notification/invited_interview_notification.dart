import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/chat/zego/zego.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xFF12B28C);

class InvitedInterviewNotificationCard extends StatefulWidget {
  final NotificationItem notification;
  const InvitedInterviewNotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  InvitedInterviewNotificationCardState createState() =>
      InvitedInterviewNotificationCardState();
}

class InvitedInterviewNotificationCardState
    extends State<InvitedInterviewNotificationCard> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> readNoti() async {
    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        final response = await http.patch(
          Uri.parse(
              'https://api.studenthub.dev/api/notification/readNoti/${widget.notification.id}'),
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
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/interview.png',
                    fit: BoxFit.cover, width: 50, height: 50),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .invited_interview_notification(
                                widget.notification.message != null &&
                                        widget.notification.message!.project !=
                                            null
                                    ? widget
                                        .notification.message!.project!.title
                                    : '',
                                widget.notification.message != null &&
                                        widget.notification.message!
                                                .interview !=
                                            null
                                    ? DateFormat('HH:mm, dd/MM/yyyy').format(
                                        widget.notification.message!.interview!
                                            .startTime
                                            .add(const Duration(hours: 7)))
                                    : ''),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3, // Số dòng tối đa
                      ),
                      Text(
                        DateFormat('HH:mm, dd/MM/yyyy').format(widget
                            .notification.createdAt
                            .add(const Duration(hours: 7))),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      widget.notification.message != null &&
                              widget.notification.message!.interview != null &&
                              widget.notification.message!.interview!
                                      .meetingRoom !=
                                  null
                          ? SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoCallPage(
                                            conferenceID: widget
                                                .notification
                                                .message!
                                                .interview!
                                                .meetingRoom!
                                                .meetingRoomCode)),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: _green,
                                    foregroundColor: Colors.white),
                                child: const Text('Join',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          readNoti();
        },
      ),
    );
  }
}
