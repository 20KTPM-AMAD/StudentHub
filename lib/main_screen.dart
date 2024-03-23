import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/project_list_screen.dart';
import 'package:studenthub/pages/chat/message_list_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/pages/notification/notification_screen.dart';
import 'package:studenthub/pages/student_submit_proposal/all_projects_screen.dart';

const Color _green = Color(0xFF12B28C);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ProjectListScreen(),
    const DashboardScreen(),//company
    //const AllProjectsScreen(), //student
    const MessageListScreen(),
    const NotificationScreen()
  ];

  @override
  void initState() {
    super.initState();
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
            onPressed: () {},
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
