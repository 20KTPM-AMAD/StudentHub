import 'package:flutter/material.dart';
import 'package:studenthub/components/profile/select_file.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/main_screen.dart';

const Color _green = Color(0xff296e48);

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
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.cv_transcript,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Text(AppLocalizations.of(context)!.intro_four,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.resume_CV,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const SelectFileButton(),
            const SizedBox(height: 30),
            Text(AppLocalizations.of(context)!.transcript,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                          content: Text(
                            AppLocalizations.of(context)!.intro_five,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.next,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _green, foregroundColor: Colors.black),
                  child: Text(AppLocalizations.of(context)!.continue_,
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
