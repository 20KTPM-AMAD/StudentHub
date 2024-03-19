import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class SignUpStep2Screen extends StatefulWidget {
  const SignUpStep2Screen({Key? key}) : super(key: key);

  @override
  SignUpStep2ScreenState createState() => SignUpStep2ScreenState();
}

class SignUpStep2ScreenState extends State<SignUpStep2Screen> {
  bool _obscureText = true;
  bool _isChecked = false;

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
                              onPressed: () {},
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
