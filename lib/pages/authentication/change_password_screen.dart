import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {

  String? errorText;
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> changePassword() async {
    final String? token = Provider.of<AuthProvider>(context, listen: false).token;
    if (oldPassController.text.isEmpty || newPassController.text.isEmpty){
      setState(() {
        errorText = 'All fields are required';
      });
      return;
    }

    final response = await http.put(
      Uri.parse('http://34.16.137.128/api/user/changePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'oldPassword': oldPassController.text,
        'newPassword': newPassController.text
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Change password success', textAlign: TextAlign.center),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', textAlign: TextAlign.center),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const SwitchAccountScreen(),
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
                style: const TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: oldPassController,
                obscureText: true,
                hintText: 'Enter Old Password',
                icon: Icons.lock,
              ),
              CustomTextfield(
                controller: newPassController,
                obscureText: true,
                hintText: 'Enter New Password',
                icon: Icons.lock,
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
                onTap: () {changePassword();},
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
            ],
          ),
        ),
      ),
    );
  }
}