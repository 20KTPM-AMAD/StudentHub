import 'package:flutter/material.dart';
import 'package:studenthub/components/drop_down_upgrade.dart';

class SwitchAccountPage extends StatelessWidget {
  const SwitchAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Hub'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const DropdownUpgrade(),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Row(
                    children: [
                      Icon(Icons.person, size: 50.0, color: Colors.green),
                      SizedBox(width: 8.0),
                      Text('Profile',
                        style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Row(
                    children: [
                      Icon(Icons.settings, size: 50.0, color: Colors.green),
                      SizedBox(width: 8.0),
                      Text('Settings',
                        style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Row(
                    children: [
                      Icon(Icons.logout, size: 50.0, color: Colors.green),
                      SizedBox(width: 8.0),
                      Text('Logout',
                        style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Text(
                      'Already have an account',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
