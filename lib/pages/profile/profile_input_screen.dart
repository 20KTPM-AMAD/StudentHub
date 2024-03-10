import 'package:flutter/material.dart';
import 'package:studenthub/components/input_group.dart';
import 'package:studenthub/components/profile/radio_button_group.dart';
import 'package:studenthub/welcome_screen.dart';

const Color _green = Color(0xFF12B28C);

class ProfileInputScreen extends StatefulWidget {
  const ProfileInputScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInputScreen> createState() => _ProfileInputScreenState();
}

class _ProfileInputScreenState extends State<ProfileInputScreen> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Welcome to Student Hub',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                  'Tell us about your company and you will be on your way connect with high-skilled students',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text('How many people are in your company?',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
            const RadioButtonGroup(),
            InputGroup(name: 'Company Name'),
            InputGroup(name: 'Website'),
            InputGroup(name: 'Description'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _green, foregroundColor: Colors.black),
                  child: const Text('Continue', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
