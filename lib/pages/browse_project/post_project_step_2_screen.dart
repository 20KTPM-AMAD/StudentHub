import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/post_project_step_3.dart';

const Color _green = Color(0xFF12B28C);

enum Range {
  OneToThreeMonths,
  ThreeToSixMonths,
}

class PostProjectStep2Screen extends StatefulWidget {
  const PostProjectStep2Screen({Key? key}) : super(key: key);

  @override
  PostProjectStep2State createState() => PostProjectStep2State();
}

class PostProjectStep2State extends State<PostProjectStep2Screen> {
  Range _range = Range.OneToThreeMonths;

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
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(children: [
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    '2/4',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Next, estimate the scope of your project',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Consider the size of your project and the timeline',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'How long will your project take?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ListTile(
                        title: const Text('1 to 3 months'),
                        leading: Radio<Range>(
                          value: Range.OneToThreeMonths,
                          groupValue: _range,
                          onChanged: (Range? value) {
                            setState(() {
                              _range = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('3 to 6 months'),
                        leading: Radio<Range>(
                          value: Range.ThreeToSixMonths,
                          groupValue: _range,
                          onChanged: (Range? value) {
                            setState(() {
                              _range = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How many students do you want for this project?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: _green),
                      ),
                      hintText: "Number Of students",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PostProjectStep3Screen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Next: Description',
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              )
            ])));
  }
}
