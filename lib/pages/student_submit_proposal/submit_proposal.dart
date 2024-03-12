import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({Key? key}) : super(key: key);

  @override
  SubmitProposalScreenState createState() => SubmitProposalScreenState();
}

class SubmitProposalScreenState extends State<SubmitProposalScreen> {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  const Text(
                    'Cover letter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  const Text(
                    'Describe why do you fit to this project',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8, //or null
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _green, width: 2),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Cancel', style: TextStyle(fontSize: 18)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _green, foregroundColor: Colors.black),
                    child: const Text('Submit proposal',
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
