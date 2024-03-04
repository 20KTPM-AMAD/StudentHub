import 'package:flutter/material.dart';
// import 'loginScreen.dart';
// import 'signUpStep2Screen.dart';

const Color _green = Color(0xFF12B28C);

class SignUpStep1Screen extends StatefulWidget {
  const SignUpStep1Screen({Key? key}) : super(key: key);

  @override
  SignUpStep1ScreenState createState() => SignUpStep1ScreenState();
}

class SignUpStep1ScreenState extends State<SignUpStep1Screen> {
  bool? _userType;

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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Join as company or  Student',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
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
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: RadioListTile<bool>(
                                  title: const Text('I’m a company, find engineer for project', style: TextStyle(fontSize: 18),),
                                  value: true,
                                  groupValue: _userType,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _userType = value;
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
                              const SizedBox(height: 20,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: RadioListTile<bool>(
                                  title: const Text('I’m a student, find project', style: TextStyle(fontSize: 18),),
                                  value: false,
                                  groupValue: _userType,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _userType = value;
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
                        ),

                        const SizedBox(height: 40),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpStep2Screen()),);
                              },
                            style: ElevatedButton.styleFrom(
                                primary: _green,
                                onPrimary: Colors.black
                            ),
                            child: const Text('Create account', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
                                },
                              style: TextButton.styleFrom(
                                primary: _green,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,),
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
    );
  }
}
