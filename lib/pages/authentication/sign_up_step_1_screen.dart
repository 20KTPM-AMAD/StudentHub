import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_step_2_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class SignUpStep1Screen extends StatefulWidget {
  const SignUpStep1Screen({Key? key}) : super(key: key);

  @override
  SignUpStep1ScreenState createState() => SignUpStep1ScreenState();
}

class SignUpStep1ScreenState extends State<SignUpStep1Screen> {
  bool? _isCompanySelected;
  int? _userTypeValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/thinking.jpg'),
                      Text(
                        AppLocalizations.of(context)!.join_as_company_or_student,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: 350,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: RadioListTile<bool>(
                                      title: Text(AppLocalizations.of(context)!.join_company),
                                      value: true,
                                      groupValue: _isCompanySelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isCompanySelected = value;
                                          _userTypeValue = value! ? 1 : 0;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      contentPadding: EdgeInsets.zero,
                                      secondary: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Icon(Icons.business),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: RadioListTile<bool>(
                                      title: Text(AppLocalizations.of(context)!.join_student),
                                      value: false,
                                      groupValue: _isCompanySelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isCompanySelected = value;
                                          _userTypeValue = value! ? 1 : 0;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      contentPadding: EdgeInsets.zero,
                                      secondary: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Icon(Icons.school),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ,
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                print(_userTypeValue);
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: SignUpStep2Screen(userType: _userTypeValue,),
                                        type: PageTransitionType.bottomToTop));
                              },
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
                                    AppLocalizations.of(context)!.create_account,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                      style: const TextStyle(
                                        fontSize: 16
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.login}',
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
