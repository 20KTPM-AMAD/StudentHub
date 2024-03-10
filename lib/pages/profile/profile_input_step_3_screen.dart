import 'package:flutter/material.dart';
import 'package:studenthub/components/profile/select_file.dart';

const Color _green = Color(0xFF12B28C);

class ProfileInputStep3Screen extends StatefulWidget {
  const ProfileInputStep3Screen({Key? key}) : super(key: key);

  @override
  State<ProfileInputStep3Screen> createState() =>
      _ProfileInputStep3ScreenState();
}

class _ProfileInputStep3ScreenState extends State<ProfileInputStep3Screen> {
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
                'CV & Transript',
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
            const Text('Resume/CV (*)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const SelectFileButton(),
            const SizedBox(height: 30),
            const Text('Transript (*)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const SelectFileButton(),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Center(child: Text('Welcome')),
                          content: const Text('Welcome to StudentHub, a marketplace to connect Student <> Real-world projects'),
                          actions: [
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: const Text('Next'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _green, foregroundColor: Colors.black),
                  child: const Text('Continue', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
