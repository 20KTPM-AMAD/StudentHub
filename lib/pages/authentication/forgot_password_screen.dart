import 'package:flutter/material.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  String? errorText;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty){
      setState(() {
        errorText = 'Email can not be blank';
      });
      return;
    }

    final response = await http.post(
      Uri.parse('http://34.16.137.128/api/user/forgotPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': emailController.text,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201){
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
    }
    else {
      final jsonResponse = json.decode(response.body);
      print('Failed to reset password:  ${response.body}');
      setState(() {
        errorText = jsonResponse['errorDetails'];
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
              Image.asset('assets/images/reset-password.png'),
              Text(
                AppLocalizations.of(context)!.forgot_password,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                obscureText: false,
                hintText: AppLocalizations.of(context)!.enter_email,
                icon: Icons.alternate_email, controller: emailController,
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
              GestureDetector(
                onTap: () {forgotPassword();},
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
                      AppLocalizations.of(context)!.reset_password,
                      style: TextStyle(
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
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const LoginScreen(),
                          type: PageTransitionType.bottomToTop));
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.have_an_account,
                        style: TextStyle(
                          color: blackColor,fontSize: 16
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          color: primaryColor,fontSize: 16
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