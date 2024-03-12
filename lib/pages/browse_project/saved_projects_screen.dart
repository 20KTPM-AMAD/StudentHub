import 'package:flutter/material.dart';
import 'package:studenthub/components/project/card_saved_project.dart';

const Color _green = Color(0xFF12B28C);

class SavedProjectsScreen extends StatefulWidget {
  const SavedProjectsScreen({Key? key}) : super(key: key);

  @override
  SavedProjectsState createState() => SavedProjectsState();
}

class SavedProjectsState extends State<SavedProjectsScreen>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SavedProjectCard(),
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