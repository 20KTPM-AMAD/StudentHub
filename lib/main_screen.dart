import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/pages/browse_project/project_list_screen.dart';
import 'package:studenthub/pages/chat/message_list_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/pages/notification/notification_screen.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/pages/student_submit_proposal/all_projects_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';

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
    const NotificationScreen()
  ];

  // role

  @override
  void initState() {
    super.initState();

    if (Provider.of<AuthProvider>(context, listen: false).loginUser == null) {
      _getUserInfo();
    }

    checkRole();
  }

  void checkRole() {
    Provider.of<AuthProvider>(context, listen: false).role == UserRole.Company
        ? setState(() {
            _tabs = [
              const ProjectListScreen(),
              const DashboardScreen(),
              const MessageListScreen(),
              const NotificationScreen()
            ];
          })
        : setState(() {
            _tabs = [
              const ProjectListScreen(),
              const AllProjectsScreen(),
              const MessageListScreen(),
              const NotificationScreen()
            ];
          });
  }

  Future<void> _getUserInfo() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Provider.of<AuthProvider>(context, listen: false)
            .setLoginUser(User.fromJson(jsonResponse['result']));

        var loginUser =
            Provider.of<AuthProvider>(context, listen: false).loginUser;

        if (loginUser!.roles.contains(1)) {
          Provider.of<AuthProvider>(context, listen: false)
              .setRole(UserRole.Company);
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .setRole(UserRole.Student);
        }
      } else {
        print('Failed to get user info: ${response.body}');
      }
    }
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
              icon: const Icon(Icons.notifications),
              label: 'Alerts',
              backgroundColor: Colors.grey[400]),
        ],
      ),
    );
  }
}
