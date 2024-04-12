import 'package:flutter/material.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:page_transition/page_transition.dart';
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
  String? errorText;
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
      setState(() {
        errorText = 'All fields are required';
      });
      return;
    }

    print("Email: ${emailController.text}");
    print("FullName: ${fullNameController.text}");
    print("Password: ${passwordController.text}");
    print("Role: $_userTypeValue");

    final response = await http.post(
      Uri.parse('http://34.16.137.128/api/auth/sign-up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': emailController.text,
        'fullname': fullNameController.text,
        'password': passwordController.text,
        'role': _userTypeValue,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.success, style: const TextStyle(fontWeight: FontWeight.bold),),
            content: Text(jsonResponse['result']['message']),
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
      final jsonResponse = json.decode(response.body);
      print('Failed to register  ${response.body}');

      setState(() {
        if (jsonResponse['errorDetails'] != null) {
          if (jsonResponse['errorDetails'].contains("email must be an email")) {
            errorText = 'Invalid email format';
          } else if (jsonResponse['errorDetails'].contains("password is too weak, password must be longer than or equal to 8 characters")) {
            errorText = 'Password is too weak. It must be longer than or equal to 8 characters.';
          } else {
            errorText = jsonResponse['errorDetails'] ?? 'Failed to register';
          }
        } else {
          errorText = jsonResponse['errorDetails'] ?? 'Failed to register';
        }
      });
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
                AppLocalizations.of(context)!.sign_up,
                style: const TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                title: 'Email',
                controller: emailController,
                obscureText: false,
                hintText: AppLocalizations.of(context)!.enter_work_email_address,
                icon: Icons.alternate_email,
              ),
              CustomTextfield(
                title: AppLocalizations.of(context)!.fullname,
                controller: fullNameController,
                obscureText: false,
                hintText: AppLocalizations.of(context)!.enter_fullname,
                icon: Icons.person,
              ),
              CustomTextfield(
                title: AppLocalizations.of(context)!.password,
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
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                height: 10,
              ),
              if (errorText != null)
                GestureDetector(
                  onTap: () {},  // Bạn có thể thêm một hành động khi nhấp vào đây nếu cần
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD0342C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      errorText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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