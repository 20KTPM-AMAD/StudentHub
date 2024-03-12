import 'package:flutter/material.dart';
import 'package:studenthub/components/notification/chat_notification.dart';
import 'package:studenthub/components/notification/invited_interview_notification.dart';
import 'package:studenthub/components/notification/offer_notification.dart';
import 'package:studenthub/components/notification/submitted_notification.dart';

const Color _green = Color(0xFF12B28C);

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SubmittedNotificationCard(),
                    OfferNotificationCard(),
                    InvitedInterviewNotificationCard(),
                    ChatNotificationCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.view_list), label: 'Projects'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Dashboard',),
          NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Alerts',),
        ],
        backgroundColor: _green,
      ),
    );
  }
}