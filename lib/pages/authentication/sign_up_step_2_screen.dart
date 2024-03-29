import 'package:flutter/material.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class SignUpStep2Screen extends StatefulWidget {
  final int? userType;
  const SignUpStep2Screen({Key? key, this.userType}) : super(key: key);

  @override
  SignUpStep2ScreenState createState() => SignUpStep2ScreenState();
}

class SignUpStep2ScreenState extends State<SignUpStep2Screen> {

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/signup.png'),
              Text(
                AppLocalizations.of(context)!.sign_up_as_Company,
                style: const TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: emailController,
                obscureText: false,
                hintText: AppLocalizations.of(context)!.enter_work_email_address,
                icon: Icons.alternate_email,
              ),
              CustomTextfield(
                controller: fullNameController,
                obscureText: false,
                hintText: AppLocalizations.of(context)!.enter_fullname,
                icon: Icons.person,
              ),
              CustomTextfield(
                controller: passwordController,
                obscureText: true,
                hintText: AppLocalizations.of(context)!.password,
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {signUp();},
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.looking_for_a_project,
                        style: TextStyle(
                          color: blackColor, fontSize: 16
                        ),
                      ),
                      TextSpan(
                        text: ' ${AppLocalizations.of(context)!.apply_as_student}',
                        style: TextStyle(
                          color: primaryColor, fontSize: 16
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}