import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/chat/message_detail_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/models/Message.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xFF12B28C);

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool isLoading = false;
  List<Message> messages = [];
  int userId = 0;

  @override
  void initState() {
    super.initState();
    getAllMessages();
  }

  Future<void> getAllMessages() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      userId = Provider.of<AuthProvider>(context, listen: false).loginUser!.id;
      if (token != null) {
        final response = await http.get(
          Uri.parse('https://api.studenthub.dev/api/message'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          if (jsonResponse['result'] is List){
            setState(() {
              messages = (jsonResponse['result'] as List).map((data) => Message.fromJson(data)).toList();
            });
          }
        }
      }
    } catch (error) {
      print('Failed to get list message: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildMessageList();
  }

  Widget buildMessageList(){
    return RefreshIndicator(
      onRefresh: getAllMessages,
      child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: messages.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          itemBuilder: (context, index){
            if (messages.isEmpty) {
              return const Center(
                child: Text('There are currently no messages'),
              );
            }
            final message = messages[index];
            final isMe = message.sender.id == userId || message.receiver.id == userId;
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageDetailScreen(message: message)),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    isMe ? message.receiver.fullname : message.sender.fullname,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  message.formattedCreatedAt(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              message.project!.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              message.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(
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
          },
      ),
    );
  }
}
