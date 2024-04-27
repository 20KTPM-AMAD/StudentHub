import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/drop_down_upgrade.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/User.dart';
import 'package:studenthub/pages/authentication/change_password_screen.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:studenthub/pages/profile/profile_edit_screen.dart';
import 'package:studenthub/pages/profile/profile_input_screen.dart';
import 'package:studenthub/pages/profile/profile_input_step_1_screen.dart';
import 'package:studenthub/pages/settings/setting_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/auth_provider.dart';

const Color primaryColor = Color(0xff296e48);

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({Key? key}) : super(key: key);

  @override
  SwitchAccountScreenState createState() => SwitchAccountScreenState();
}

class SwitchAccountScreenState extends State<SwitchAccountScreen> {
  late final String? token;
  String? selectedDropdownValue = 'Company';
  String? fullname = '';
  List<dynamic> roles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).role == UserRole.Company
        ? selectedDropdownValue = 'Company'
        : selectedDropdownValue = 'Student';
    token = Provider.of<AuthProvider>(context, listen: false).token;
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Provider.of<AuthProvider>(context, listen: false)
            .setLoginUser(User.fromJson(jsonResponse['result']));
        setState(() {
          fullname = Provider.of<AuthProvider>(context, listen: false)
              .loginUser
              ?.fullname;
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
    print('Token when logout $token');
    final response = await http.post(
      Uri.parse('http://34.16.137.128/api/auth/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.success,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              AppLocalizations.of(context)!.logout_success,
              textAlign: TextAlign.center,
            ),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.fail,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              AppLocalizations.of(context)!.logout_fail,
              textAlign: TextAlign.center,
            ),
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
    }
  }

  dynamic getProfile() async {
    final response = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });

    final jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  Future<bool> IsCreateProfile(String role) async {
    dynamic jsonResponse = await getProfile();
    return (jsonResponse['result'] != null &&
        jsonResponse['result'][role] != null);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
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
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          // Center the content
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align to the start of the column
            children: [
              const SizedBox(height: 30),
              DropdownUpgrade(
                onValueChanged: (value) {
                  setState(() {
                    selectedDropdownValue = value;
                    selectedDropdownValue == 'Company'
                        ? Provider.of<AuthProvider>(context, listen: false)
                            .setRole(UserRole.Company)
                        : Provider.of<AuthProvider>(context, listen: false)
                            .setRole(UserRole.Student);

                    print('Role');
                    print(
                        Provider.of<AuthProvider>(context, listen: false).role);
                  });
                },
                list: list, // Pass the updated list here
              ),
              const SizedBox(height: 50),
              _buildButton('assets/images/user.jpg',
                  AppLocalizations.of(context)!.profile, () async {
                if (selectedDropdownValue == 'Company') {
                  bool isCreateProfileCompany =
                      await IsCreateProfile('company');
                  if (isCreateProfileCompany) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileEditScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileInputScreen(),
                      ),
                    );
                  }
                } else {
                  bool isCreateProfileStudent =
                      await IsCreateProfile('Student');
                  if (isCreateProfileStudent) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileEditScreen(),
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
                }
              }),
              const SizedBox(height: 8),
              _buildButton('assets/images/password_icon.png',
                  AppLocalizations.of(context)!.change_password, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen(),
                  ),
                );
              }),
              const SizedBox(height: 8),
              _buildButton('assets/images/settings.jpg',
                  AppLocalizations.of(context)!.settings, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }),
              const SizedBox(height: 8),
              _buildButton('assets/images/logout.png',
                  AppLocalizations.of(context)!.logout, () {
                logout();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String imagePath, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.symmetric(
            vertical: 10), // Add margin for spacing between buttons
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Center the content
          children: [
            Image.asset(
              imagePath,
              height: 50.0,
              width: 50.0,
            ),
            const SizedBox(width: 20.0),
            Text(
              label,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
