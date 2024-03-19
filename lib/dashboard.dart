import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/post_project_step_1_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/pages/browse_project/project_list_screen.dart';
import 'package:studenthub/pages/chat/message_list_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/pages/notification/notification_screen.dart';
import 'package:studenthub/utils/navigator.dart';

const Color _green = Color(0xFF12B28C);

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ProjectListScreen(),
    const DashboardScreen(),
    const MessageListScreen(),
    const NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CustomNavigationBar(
        height: 60,
        backgroundColor: _green, // Màu nền của NavigationBar
        destinations: [
          CustomNavigationDestination(icon: const Icon(Icons.view_list), label: 'Projects'),
          CustomNavigationDestination(icon: const Icon(Icons.home), label: 'Dashboard',),
          CustomNavigationDestination(icon: const Icon(Icons.message), label: 'Message'),
          CustomNavigationDestination(icon: const Icon(Icons.notifications), label: 'Alerts',),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
