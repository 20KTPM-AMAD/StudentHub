import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

enum Choices { justMe }

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
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
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome to Student Hub',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Company name',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: _green),
                                ),
                                hintText: "Enter company name",
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
                              'Website',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: _green),
                                ),
                                hintText: "Enter web site",
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
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextField(
                              maxLines: 6, //or null
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: _green),
                                ),
                                hintText: "Description...",
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
                              'How many people are in your company?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            ListTile(
                              title: const Text('Just me'),
                              leading: Radio<Choices>(
                                value: Choices.justMe,
                                groupValue: Choices.justMe,
                                onChanged: (Choices? value) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: _green,
                            fixedSize: const Size(120, 32),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child:
                            const Text('Edit', style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[300],
                            fixedSize: const Size(120, 32),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: const Text('Cancel',
                            style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(width: 20),
                    ],
                  )),
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
