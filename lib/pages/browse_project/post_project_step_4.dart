import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

enum Range {
  OneToThreeMonths,
  ThreeToSixMonths,
}

class PostProjectStep4Screen extends StatefulWidget {
  const PostProjectStep4Screen({Key? key}) : super(key: key);

  @override
  PostProjectStep4State createState() => PostProjectStep4State();
}

class PostProjectStep4State extends State<PostProjectStep4Screen> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      '4/4',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Project details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      'Title of the job',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: _green,
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Student are looking for:',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '\u2022 Clear expectation about your project and deliverables',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '\u2022 The skills required for your project',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '\u2022 Details about your project',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project scope',
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '\u2022 3 - 6 months',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.person_2,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student required:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '\u2022 6 students',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Post job',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                )
              ],
            )));
  }
}
