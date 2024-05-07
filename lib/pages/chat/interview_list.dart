import 'package:flutter/material.dart';
import 'package:studenthub/components/chat/interview_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xff296e48 );

class InterviewListScreen extends StatefulWidget {
  const InterviewListScreen({Key? key}) : super(key: key);

  @override
  InterviewListScreenState createState() => InterviewListScreenState();
}

class InterviewListScreenState extends State<InterviewListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.list_of_interviews,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 555,
                    width: double.infinity,
                    child: ListView(
                      children: const [
                        InterviewCard(),
                      ],
                    ),
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
