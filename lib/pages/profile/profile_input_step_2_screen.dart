import 'package:flutter/material.dart';
import 'package:studenthub/components/profile/info_card.dart';
import 'package:studenthub/components/profile/multi_select.dart';
import 'package:studenthub/pages/profile/profile_input_step_3_screen.dart';

const Color _green = Color(0xFF12B28C);

class ProfileInputStep2Screen extends StatefulWidget {
  const ProfileInputStep2Screen({Key? key}) : super(key: key);

  @override
  State<ProfileInputStep2Screen> createState() =>
      _ProfileInputStep2ScreenState();
}

class _ProfileInputStep2ScreenState extends State<ProfileInputStep2Screen> {
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
                'Experiences',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Project',
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
                title: 'Intelligent Taxi Dispatching system',
                detail: '9/2020-12/2020, 4 months'),
            const SizedBox(height: 20),
            const Text(
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia,...',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Skillset',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // select
            const MultiSelect(),
            const SizedBox(height: 20),
            const InfoCard(
                title: 'Intelligent Taxi Dispatching system',
                detail: '9/2020-12/2020, 4 months'),
            const SizedBox(height: 20),
            const Text(
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia,...',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileInputStep3Screen()),
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
