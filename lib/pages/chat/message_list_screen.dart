import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:studenthub/components/chat/message_card.dart';

const Color _green = Color(0xFF12B28C);

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  MessageListScreenState createState() => MessageListScreenState();
}

class MessageListScreenState extends State<MessageListScreen> {
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 365,
                        child: AutoCompleteTextField<String>(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          itemSubmitted: (String item) {
                            // Xử lý khi người dùng chọn gợi ý
                          },
                          key: key,
                          suggestions: suggestions,
                          itemBuilder: (context, String suggestion) => ListTile(
                            title: Text(suggestion),
                          ),
                          itemSorter: (String a, String b) => a.compareTo(b),
                          itemFilter: (String suggestion, String query) {
                            return suggestion
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 555,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: ListView(
                      children: const [
                        MessageCard(),
                        MessageCard(),
                        MessageCard(),
                        MessageCard(),
                        MessageCard(),
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
