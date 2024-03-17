import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luis Pham'),
        backgroundColor: Colors.green.shade200,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.pending,
              color: _green,
            ),
            iconSize: 35,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.green.shade200,
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  '1 FEB 12:00',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: _green),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Hi Luis, how are you doing?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: _green),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'I am doing great!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  '08:12',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Can you update on the project progress?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: _green),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Message',
                        style: TextStyle(color: Colors.white54),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
