import 'package:flutter/material.dart';
import 'package:studenthub/components/input_group.dart';
import 'package:studenthub/components/radio_button_group.dart';

class ProfileInputPage extends StatefulWidget {
  const ProfileInputPage({Key? key}) : super(key: key);

  @override
  State<ProfileInputPage> createState() => _ProfileInputPageState();
}

class _ProfileInputPageState extends State<ProfileInputPage> {

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Student Hub'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Welcome to Student Hub',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Tell us about your company and you will be on your way connect with high-skilled students',
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'How many people are in your company?'),
            ),
            const RadioButtonGroup(),
            const InputGroup(name: 'Company Name'),
            const InputGroup(name: 'Website'),
            const InputGroup(name: 'Description'),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust the value as needed
                    ),
                  ),
                ),
                onPressed: () {  },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}