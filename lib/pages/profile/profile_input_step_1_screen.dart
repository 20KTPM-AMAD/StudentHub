import 'package:flutter/material.dart';
import 'package:studenthub/components/drop_down.dart';
import 'package:studenthub/components/profile/info_card.dart';
import 'package:studenthub/components/profile/multi_select.dart';
import 'package:studenthub/pages/profile/profile_input_step_2_screen.dart';

const Color _green = Color(0xFF12B28C);

class ProfileInputStep1Screen extends StatefulWidget {
  const ProfileInputStep1Screen({Key? key}) : super(key: key);

  @override
  State<ProfileInputStep1Screen> createState() =>
      _ProfileInputStep1ScreenState();
}

class _ProfileInputStep1ScreenState extends State<ProfileInputStep1Screen> {
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
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
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
            const Text(
                'Tell us about your self and you will be on your way connect with real-world project',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Techstack',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Dropdown(),
            const SizedBox(height: 20),
            const Text('Skillset',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // select
            const MultiSelect(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(2),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(2),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              'English: Native or Bilingual',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Education',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(2),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 25,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
            const InfoCard(
                title: 'Le Hong Phong High School', detail: '2008-2010'),
            const InfoCard(
                title: 'Ho Chi Minh City University of Sciences',
                detail: '2010-2014'),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileInputStep2Screen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _green, foregroundColor: Colors.black),
                  child: const Text('Next', style: TextStyle(fontSize: 18)),
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
