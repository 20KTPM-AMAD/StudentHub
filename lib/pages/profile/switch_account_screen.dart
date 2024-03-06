import 'package:flutter/material.dart';
import 'package:studenthub/components/drop_down_upgrade.dart';
import 'package:studenthub/pages/profile/profile_input_screen.dart';

const Color _green = Color(0xFF12B28C);

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({Key? key}) : super(key: key);

  @override
  _SwitchAccountScreenState createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const DropdownUpgrade(),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileInputScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Row(
                  children: [
                    Material(
                      shape: CircleBorder(), // Thiết lập hình dạng là hình tròn
                      color: _green, // Thiết lập màu nền của nút
                      child: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 35,
                          ),
                          color: _green,
                          onPressed: null // Màu của biểu tượng
                          ),
                    ),
                    SizedBox(width: 20.0),
                    Text('Profile', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 50.0,
                      color: _green,
                    ),
                    SizedBox(width: 20.0),
                    Text('Settings', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Row(
                  children: [
                    SizedBox(width: 4.0),
                    Icon(
                      Icons.logout,
                      size: 50.0,
                      color: _green,
                    ),
                    SizedBox(width: 20.0),
                    Text('Logout', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Text(
                    'Already have an account',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
