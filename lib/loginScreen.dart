import 'package:flutter/material.dart';
import 'signUpStep1Screen.dart';

const Color _green = Color(0xFF12B28C);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

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
                    'Login with Student Hub',

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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Username or email',
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
                                hintText: "Enter username or email",
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
                              'Password',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: _green)
                                ),
                                hintText: "Enter password",
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
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: _green,
                                onPrimary: Colors.black
                            ),
                            child: const Text('Sign In', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Don’t have a Student Hub account?',
                      style: TextStyle(
                        color: _green,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpStep1Screen()),);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _green,
                          onPrimary: Colors.black,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(),
      ),
    );
  }
}
