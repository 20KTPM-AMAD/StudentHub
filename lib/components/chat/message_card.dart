import 'package:flutter/material.dart';
import 'package:studenthub/pages/chat/message_detail_screen.dart';

const Color _green = Color(0xFF12B28C);

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MessageDetailScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: Image.asset('assets/images/user.jpg').image,
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Luis Pham',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          '08:43',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Senior frontend developer (Fintech)',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Clear expectation about your project or deliverables',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
