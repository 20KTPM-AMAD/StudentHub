import 'package:flutter/material.dart';
import 'package:studenthub/components/company_project/card_saved_project.dart';
import 'package:studenthub/pages/browse_project/project_list_screen.dart';
import 'package:studenthub/pages/chat/message_list_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/pages/notification/notification_screen.dart';

const Color _green = Color(0xFF12B28C);

class SavedProjectsScreen extends StatefulWidget {
  const SavedProjectsScreen({Key? key}) : super(key: key);

  @override
  SavedProjectsState createState() => SavedProjectsState();
}

class SavedProjectsState extends State<SavedProjectsScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ProjectListScreen(),
    const DashboardScreen(),//company
    //const AllProjectsScreen(), //student
    const MessageListScreen(),
    const NotificationScreen()
  ];

  bool isLoading = false;
  int currentPage = 0;
  int itemsPerPage = 10;
  List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved projects'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadMoreItems();
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      SavedProjectCard(),
                      if (isLoading) _buildProgressIndicator(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _loadMoreItems() {
    setState(() {
      isLoading = true;
    });

    // Simulate a delay for fetching new items
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        int currentLength = items.length;
        for (int i = currentLength; i < currentLength + itemsPerPage; i++) {
          items.add('Item $i');
        }
        isLoading = false;
      });
    });
  }
}
