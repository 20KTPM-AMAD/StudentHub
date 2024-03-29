import 'package:flutter/material.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studenthub/pages/authentication/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

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
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
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