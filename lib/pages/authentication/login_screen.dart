import 'package:flutter/material.dart';
import 'package:studenthub/main_screen.dart';
import 'sign_up_step_1_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const Color _green = Color(0xFF12B28C);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields are required'),
        ),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://34.125.167.164/api/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['result'] != null && jsonResponse['result']['token'] != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()),);
    }
    else {
      print('Failed to login: ${response.body}');
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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.login_one,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.username,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                  hintText: AppLocalizations.of(context)!.login_two,
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
                                controller: passwordController,
                                obscureText: _obscureText,
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
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                login();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _green,
                                  foregroundColor: Colors.black
                              ),
                              child: Text(AppLocalizations.of(context)!.sign_in, style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height - 600),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                    AppLocalizations.of(context)!.login_four,
                      style: const TextStyle(
                        color: _green,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpStep1Screen()),);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.sign_up,
                          style: const TextStyle(fontSize: 18, color: _green, decoration: TextDecoration.underline,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(),
      ),
    );
  }
}
