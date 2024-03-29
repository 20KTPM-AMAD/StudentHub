import 'package:flutter/material.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const Color _green = Color(0xFF12B28C);

class SignUpStep2Screen extends StatefulWidget {
  final int? userType;
  const SignUpStep2Screen({Key? key, this.userType}) : super(key: key);

  @override
  SignUpStep2ScreenState createState() => SignUpStep2ScreenState();
}

class SignUpStep2ScreenState extends State<SignUpStep2Screen> {
  bool _obscureText = true;
  bool _isChecked = false;
  int? _userTypeValue;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userTypeValue = widget.userType;
  }

  Future<void> signUp() async {
    if (emailController.text.isEmpty || fullNameController.text.isEmpty || passwordController.text.isEmpty || _userTypeValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields are required'),
        ),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://34.125.167.164/api/auth/sign-up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': emailController.text,
        'fullName': fullNameController.text,
        'password': passwordController.text,
        'role': _userTypeValue,
      }),
    );

    if (response.body == '{}') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SwitchAccountScreen()),
        );
    } else {
      print('Failed to register: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SwitchAccountScreen()),);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.sign_up_as_Company,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.fullname,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: fullNameController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(color: _green),
                                        ),
                                        hintText: AppLocalizations.of(context)!.enter_fullname,
                                        hintStyle: const TextStyle(color: _green),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Email',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(color: _green),
                                        ),
                                        hintText: AppLocalizations.of(context)!.enter_work_email_address,
                                        hintStyle: const TextStyle(color: _green),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.password,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      obscureText: _obscureText,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(color: _green)
                                        ),
                                        hintText: AppLocalizations.of(context)!.login_three,
                                        hintStyle: const TextStyle(color: _green),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                CheckboxListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.agree_to_studenthub,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_isChecked) {
                                  signUp();
                                }
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('You must agree to the terms of use'),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _green,
                                  foregroundColor: Colors.black
                              ),
                              child: Text(AppLocalizations.of(context)!.create_my_account, style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.looking_for_a_project,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.apply_as_student,
                                  style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
