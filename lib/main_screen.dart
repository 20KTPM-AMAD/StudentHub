import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/browse_project/project_list_screen.dart';
import 'package:studenthub/pages/chat/interview_list_screen.dart';
import 'package:studenthub/pages/chat/message_list_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/pages/notification/notification_screen.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/pages/student_submit_proposal/all_projects_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/socket_manager.dart';

import 'models/User.dart';

const Color _green = Color(0xff296e48);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late List<Widget> _tabs = [
    const ProjectListScreen(),
    const DashboardScreen(),
    const MessageListScreen(),
    const InterviewListScreen(),
    const NotificationScreen()
  ];

  // role

  @override
  void initState() {
    super.initState();

    if (Provider.of<AuthProvider>(context, listen: false).loginUser == null) {
      checkRole();
    }
    connectSocket();
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
      Provider.of<AuthProvider>(context, listen: false).setCountNoti(
          Provider.of<AuthProvider>(context, listen: false).countNoti + 1);
    }
  }

  void checkRole() {
    Provider.of<AuthProvider>(context, listen: false).role == UserRole.Company
        ? setState(() {
            _tabs = [
              const ProjectListScreen(),
              const DashboardScreen(),
              const MessageListScreen(),
              const InterviewListScreen(),
              const NotificationScreen()
            ];
          })
        : setState(() {
            _tabs = [
              const ProjectListScreen(),
              const AllProjectsScreen(),
              const MessageListScreen(),
              const InterviewListScreen(),
              const NotificationScreen()
            ];
          });
  }

  @override
  void dispose() {
    SocketManager().unregisterSocketListener(onReceiveNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SwitchAccountScreen()),
              ).then((result) {
                checkRole();
              });
            },
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _green,
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 4) {
            Provider.of<AuthProvider>(context, listen: false).clearNoti();
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.view_list),
            label: 'Projects',
            backgroundColor: Colors.grey[400],
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Dashboard',
              backgroundColor: Colors.grey[400]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: 'Message',
              backgroundColor: Colors.grey[400]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.videocam),
              label: 'Interview',
              backgroundColor: Colors.grey[400]),
          BottomNavigationBarItem(
              icon:
                  Provider.of<AuthProvider>(context, listen: false).countNoti >
                          0
                      ? Badge(
                          label: Text(
                              '$Provider.of<AuthProvider>(context, listen: false).countNoti'),
                          child: const Icon(Icons.notifications),
                        )
                      : const Icon(Icons.notifications),
              label: 'Alerts',
              backgroundColor: Colors.grey[400]),
        ],
      ),
    );
  }
}
