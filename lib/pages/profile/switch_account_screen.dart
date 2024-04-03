import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/drop_down_upgrade.dart';
import 'package:studenthub/pages/authentication/change_password_screen.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:studenthub/pages/profile/profile_input_screen.dart';
import 'package:studenthub/pages/profile/profile_input_step_1_screen.dart';
import 'package:studenthub/pages/settings/setting_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xFF12B28C);

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({Key? key, this.userRole}) : super(key: key);
  final userRole;

  @override
  SwitchAccountScreenState createState() => SwitchAccountScreenState();
}

class SwitchAccountScreenState extends State<SwitchAccountScreen> {
  String? selectedDropdownValue = 'Company';
  String? fullname = '';
  List<dynamic> roles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final String? token = Provider.of<AuthProvider>(context, listen: false).token;
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          fullname = jsonResponse['result']['fullname'];
          roles = jsonResponse['result']['roles'];
          isLoading = false;
        });
      } else {
        print('Failed to get user info: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> logout() async {
    final String? token = Provider.of<AuthProvider>(context, listen: false).token;

    print('Token when logout $token');
    final response = await http.post(
      Uri.parse('http://34.16.137.128/api/auth/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Success',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('Logout success'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const LoginScreen(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Failed to login  ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Update the list based on the received fullname and roles
    List<Map<String, dynamic>> list = [
      {'name': fullname, 'position': 'Company', 'icon': Icons.person},
      {'name': fullname, 'position': 'Student', 'icon': Icons.person}
    ];

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
              list: list, // Pass the updated list here
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
                      shape: CircleBorder(),
                      color: _green,
                      child: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 35,
                          ),
                          color: _green,
                          onPressed: null
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                      AppLocalizations.of(context)!.profile,
                      style: const TextStyle(fontSize: 20),
                    )
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
                    builder: (context) => const ChangePasswordScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Row(
                  children: [
                    Icon(
                      Icons.password_outlined,
                      size: 50.0,
                      color: _green,
                    ),
                    SizedBox(width: 20.0),
                    Text('Change password',
                        style: TextStyle(fontSize: 20))
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
                    builder: (context) => const SettingsScreen(),
                  ),
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
              onTap: () {
                logout();
              },
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
