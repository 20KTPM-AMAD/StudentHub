import 'package:flutter/material.dart';
import 'package:studenthub/components/company_project/tab_all_projects.dart';


const Color _green = Color(0xFF12B28C);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<DashboardScreen>{
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your project',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              foregroundColor: Colors.black
                          ),
                          child: const Text('Post a project', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            const TabBar(
                                tabs: [
                                  Tab(text: 'All Projects'),
                                  Tab(text: 'Working'),
                                  Tab(text: 'Archived'),
                                ]
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - kToolbarHeight - 200, // Giảm đi kích thước của AppBar và khoảng cách dưới cùng
                              child: const TabBarView(
                                children: [
                                  AllProjectsTab(),
                                  Center(
                                    child: Text('Working Projects Content'),
                                  ),
                                  Center(
                                    child: Text('Archived Projects Content'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
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
