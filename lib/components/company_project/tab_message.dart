import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/components/chat/message_project_card.dart';

const Color _green = Color(0xff296e48 );

class MessageListTab extends StatefulWidget {
  final int projectId;
  const MessageListTab({Key? key, required this.projectId}) : super(key: key);

  @override
  MessageListTabState createState() => MessageListTabState();
}

class MessageListTabState extends State<MessageListTab> {
  @override
  void initState() {
    super.initState();
  }

  List<String> suggestions = [
    'Flutter',
    'Dart',
    'Mobile',
    'App',
    'Development',
  ];
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              height: 555,
              width: double.infinity,
              child: ListView(
                children: [
                  MessageProjectCard(projectId: widget.projectId,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
