import 'package:flutter/material.dart';
import 'package:studenthub/components/input_group.dart';
import 'package:studenthub/components/profile/radio_button_group.dart';
import 'package:studenthub/welcome_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.welcome_to_studenthub,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                  AppLocalizations.of(context)!.intro_six,
                  style: const TextStyle(
                    fontSize: 16,
                  )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(AppLocalizations.of(context)!.how_many_people_company,
                  style: const TextStyle(
                    fontSize: 16,
                  )),
            ),
            const RadioButtonGroup(),
            InputGroup(name: AppLocalizations.of(context)!.company_name),
            InputGroup(name: AppLocalizations.of(context)!.website),
            InputGroup(name: AppLocalizations.of(context)!.description),
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
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _green, foregroundColor: Colors.black),
                  child: Text(AppLocalizations.of(context)!.continue_, style: const TextStyle(fontSize: 18)),
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
