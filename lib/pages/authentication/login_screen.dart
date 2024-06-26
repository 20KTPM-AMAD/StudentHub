import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/main_screen.dart';
import 'package:studenthub/models/User.dart';
import 'package:studenthub/pages/authentication/forgot_password_screen.dart';
import 'package:studenthub/pages/authentication/sign_up_step_1_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/socket_manager.dart';

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorText;

  Future<void> getUserInfo() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Provider.of<AuthProvider>(context, listen: false)
            .setLoginUser(User.fromJson(jsonResponse['result']));

        var loginUser =
            Provider.of<AuthProvider>(context, listen: false).loginUser;

        if (loginUser!.roles.contains(1)) {
          Provider.of<AuthProvider>(context, listen: false)
              .setRole(UserRole.Company);
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .setRole(UserRole.Student);
        }
      } else {
        print('Failed to get user info: ${response.body}');
      }
    }
  }

  Future<void> connectSocket() async {
    final loginUser =
        Provider.of<AuthProvider>(context, listen: false).loginUser;

    if (loginUser != null) {
      final socketManager = SocketManager();
      await socketManager.connectSocket(context, loginUser.id);
    }
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorText = 'All fields are required';
      });
      return;
    }

    final response = await http.post(
      Uri.parse('https://api.studenthub.dev/api/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    print(response.statusCode);

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      if (jsonResponse['result'] != null &&
          jsonResponse['result']['token'] != null) {
        Provider.of<AuthProvider>(context, listen: false)
            .setToken(jsonResponse['result']['token']);
        await getUserInfo();
        await connectSocket();
        Navigator.of(context).pushReplacement(
          PageTransition(
            child: const MainScreen(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      }
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.fail,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            content: Text(jsonResponse['errorDetails']),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Failed to login  ${response.body}');
      setState(() {
        if (jsonResponse['errorDetails'] != null) {
          if (jsonResponse['errorDetails'].contains("email must be an email")) {
            errorText = 'Invalid email format';
          } else if (jsonResponse['errorDetails'].contains(
              "password is too weak, password must be longer than or equal to 8 characters")) {
            errorText =
                'Password is too weak. It must be longer than or equal to 8 characters.';
          } else {
            errorText = jsonResponse['errorDetails'] ?? 'Failed to login';
          }
        } else {
          errorText = jsonResponse['errorDetails'] ?? 'Failed to login';
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
              Image.asset('assets/images/signin.png'),
              Text(
                AppLocalizations.of(context)!.sign_in,
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
                hintText: AppLocalizations.of(context)!.enter_email,
                icon: Icons.alternate_email,
              ),
              CustomTextfield(
                title: AppLocalizations.of(context)!.password,
                controller: passwordController,
                obscureText: true,
                hintText: AppLocalizations.of(context)!.login_three,
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  login();
                },
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
                      AppLocalizations.of(context)!.sign_in,
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
                  onTap:
                      () {}, // Bạn có thể thêm một hành động khi nhấp vào đây nếu cần
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD0342C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const ForgotPasswordScreen(),
                          type: PageTransitionType.bottomToTop));
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.forgot__password,
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const SignUpStep1Screen(),
                          type: PageTransitionType.bottomToTop));
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.login_four,
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextSpan(
                        text: ' ${AppLocalizations.of(context)!.sign_up}',
                        style: TextStyle(color: primaryColor, fontSize: 16),
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
