import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/post_project_step_2_screen.dart';

const Color _green = Color(0xFF12B28C);

class PostProjectStep1Screen extends StatefulWidget {
  const PostProjectStep1Screen({Key? key}) : super(key: key);

  @override
  PostProjectStep1State createState() => PostProjectStep1State();
}

class PostProjectStep1State extends State<PostProjectStep1Screen> {
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
                    '1/4',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Let\'start with a strong title',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'This helps your post stand out to the right students. It\'s the first thing they\'ll see, so make it impressive.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _green),
                  ),
                  hintText: "Enter a title for your project",
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'For example:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '\u2022 Build responsive WordPress site with booking/payment functionality',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '\u2022 Facebook ad specialist need for product launch',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PostProjectStep2Screen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Next: Scope',
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              )
            ])));
  }
}
