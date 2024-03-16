import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/post_project_step_1_screen.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const Text('Your jobs'),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PostProjectStep1Screen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: _green,
                              fixedSize: const Size(120, 24),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          child: const Text('Post a job',
                              style: TextStyle(fontSize: 14)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome, Hai!',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'You have no jobs!',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.view_list), label: 'Projects'),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
        ],
        backgroundColor: _green,
      ),
    );
  }
}
