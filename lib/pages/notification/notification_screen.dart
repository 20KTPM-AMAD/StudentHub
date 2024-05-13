import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/notification/accpet_offer_notification.dart';
import 'package:studenthub/components/notification/cancel_interview_notification.dart';
import 'package:studenthub/components/notification/chat_notification.dart';
import 'package:studenthub/components/notification/invited_interview_notification.dart';
import 'package:studenthub/components/notification/offer_notification.dart';
import 'package:studenthub/components/notification/submitted_notification.dart';
import 'package:studenthub/components/notification/update_interview_notification.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/socket_manager.dart';

const Color _green = Color(0xff296e48);

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = false;
  List<NotificationItem> notifications = [];

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    final token = Provider.of<AuthProvider>(context, listen: false).token;
    // Call API to get notifications
    final userId =
        Provider.of<AuthProvider>(context, listen: false).loginUser!.id;
    if (token != null) {
      final response = await http.get(
          Uri.parse(
              'https://api.studenthub.dev/api/notification/getByReceiverId/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['result'] is List) {
          setState(() {
            notifications = jsonResponse['result']
                .map<NotificationItem>(
                    (item) => NotificationItem.fromJson(item))
                .toList();
          });
          inspect(notifications);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> connectSocket() async {
    final loginUser =
        Provider.of<AuthProvider>(context, listen: false).loginUser;

    if (loginUser != null) {
      final socketManager = SocketManager();
      SocketManager().registerSocketListener(onReceiveNotification);

      await socketManager.connectSocket(context, loginUser.id);
    }
  }

  void onReceiveNotification(data) {
    if (data["notification"] != null) {
      final notification = NotificationItem.fromJson(data["notification"]);
      setState(() {
        notifications.insert(0, notification);
      });
      inspect(notifications);
    }
  }

  @override
  void initState() {
    super.initState();
    connectSocket();
    _loadData();
  }

  @override
  void dispose() {
    SocketManager().unregisterSocketListener(onReceiveNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Text(AppLocalizations.of(context)!.notification,
                      style: const TextStyle(
                          color: _green,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  notifications.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            children: notifications.map((notification) {
                              if (notification.content ==
                                  'New message created') {
                                return ChatNotificationCard(
                                    notification: notification);
                              }
                              if (notification.content
                                  .contains('New proposal')) {
                                return SubmittedNotificationCard(
                                    notification: notification);
                              }
                              if (notification.title == 'You have an OFFER!') {
                                return OfferNotificationCard(
                                    notification: notification);
                              }
                              if (notification.content == 'Interview created') {
                                return InvitedInterviewNotificationCard(
                                    notification: notification);
                              }
                              if (notification.content == 'Interview updated') {
                                return UpdateInterviewNotificationCard(
                                    notification: notification);
                              }
                              if (notification.content ==
                                  'Interview cancelled') {
                                return CancelInterviewNotificationCard(
                                    notification: notification);
                              }
                              if (notification.title ==
                                  'Candidate accepted your offer !') {
                                return AcceptOfferNotificationCard(
                                    notification: notification);
                              }
                              return const SizedBox();
                            }).toList(),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              AppLocalizations.of(context)!.no_notification,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                              )),
                        ),
                ],
              ),
            ),
          );
  }
}
