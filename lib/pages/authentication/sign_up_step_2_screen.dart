import 'package:flutter/material.dart';

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
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Sign up as Company',
                    style: TextStyle(
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
                                  const Text(
                                    'Fullname',
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
                                      hintText: "Enter fullname",
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
                                      hintText: "Enter work email address",
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
                                      hintText: "Enter password (8 or more character)",
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
                                title: const Text(
                                  'Yes, I understand and agree to StudentHub',
                                  style: TextStyle(fontSize: 15),
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
                                primary: _green,
                                onPrimary: Colors.black
                            ),
                            child: const Text('Create my account', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Looking for a project?',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                primary: _green,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Apply as student',
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
