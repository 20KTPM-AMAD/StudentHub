import 'package:flutter/material.dart';
import 'package:studenthub/components/drop_down_upgrade.dart';
import 'package:studenthub/pages/profile/profile_input_screen.dart';
import 'package:studenthub/pages/profile/profile_input_step_1_screen.dart';
import 'package:studenthub/pages/settings/setting_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({Key? key, this.userRole}) : super(key: key);
  final userRole;

  @override
  SwitchAccountScreenState createState() => SwitchAccountScreenState();
}

class SwitchAccountScreenState extends State<SwitchAccountScreen> {
  String? selectedDropdownValue = 'Company'; // State to hold the selected value
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
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            DropdownUpgrade(
              onValueChanged: (value) {
                setState(() {
                  selectedDropdownValue = value;
                });
              },
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                if (selectedDropdownValue == 'Company') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileInputScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileInputStep1Screen(),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const Material(
                      shape: CircleBorder(), // Thiết lập hình dạng là hình tròn
                      color: _green, // Thiết lập màu nền của nút
                      child: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 35,
                          ),
                          color: _green,
                          onPressed: null // Màu của biểu tượng
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(AppLocalizations.of(context)!.profile,
                        style: const TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      size: 50.0,
                      color: _green,
                    ),
                    const SizedBox(width: 20.0),
                    Text(AppLocalizations.of(context)!.settings,
                        style: const TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const SizedBox(width: 4.0),
                    const Icon(
                      Icons.logout,
                      size: 50.0,
                      color: _green,
                    ),
                    const SizedBox(width: 20.0),
                    Text(AppLocalizations.of(context)!.logout,
                        style: const TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}