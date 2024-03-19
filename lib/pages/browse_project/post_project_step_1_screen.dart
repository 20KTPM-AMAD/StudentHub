import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/post_project_step_2_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Row(
                children: [
                  const Text(
                    '1/4',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Text(
                      AppLocalizations.of(context)!.strong_title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.explain,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _green),
                  ),
                  hintText: AppLocalizations.of(context)!.title_project,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.for_example,
                    style: const TextStyle(
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
                    child: Text(AppLocalizations.of(context)!.next_scope,
                        style: const TextStyle(fontSize: 18)),
                  ),
                ],
              )
            ])));
  }
}
