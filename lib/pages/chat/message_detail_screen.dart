import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/chat/pop_up_time_choose.dart';
import 'package:studenthub/components/chat/schedule_interview_message.dart';
import 'package:studenthub/models/Message.dart';
import 'package:studenthub/models/ScheduleInterview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/socket_manager.dart';

const Color _green = Color(0xff296e48);


class MessageDetailScreen extends StatefulWidget {
  final Message message;

  const MessageDetailScreen({Key? key, required this.message})
      : super(key: key);

  @override
  State<MessageDetailScreen> createState() => MessageDetailScreenState();
}

class MessageDetailScreenState extends State<MessageDetailScreen> {
  bool isLoading = false;
  List<Message> messageList = [];
  List<String> messages = [];
  int userId = 0;
  int friendId = 0;
  bool isMe = false;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SocketManager.initializeSocket(context, widget.message.project!.id);
    SocketManager.socket.on('RECEIVE_MESSAGE', (data) {
      setState(() {
        messages.add(data['content']);
      });
    });
    getMessageList();
  }

  Future<void> getMessageList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      userId = Provider.of<AuthProvider>(context, listen: false).loginUser!.id;
      isMe = widget.message.sender!.id == userId || widget.message.receiver!.id == userId;
      friendId = isMe ? widget.message.receiver!.id : widget.message.sender!.id;

      if (token != null) {
        final response = await http.get(
          Uri.parse('https://api.studenthub.dev/api/message/${widget.message.project?.id}/user/$friendId'),
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
              messageList = jsonResponse['result'].map<Message>((data) => Message.fromJson(data)).toList();
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

  void _sendMessage() {
    String messageContent = textController.text;
    if (messageContent.isNotEmpty) {
      SocketManager.sendMessage(
        messageContent,
        widget.message.project!.id,
        userId,
        friendId,
      );

      Message newMessage = Message(
        id: messageList.length + 1,
        createdAt: DateTime.now(),
        content: messageContent,
        sender: Postman(id: userId, fullname: 'lethuy nga'),
        receiver: Postman(id: friendId, fullname: 'Phat Beau'),
        project: widget.message.project,
      );

      setState(() {
        messageList.add(newMessage);
      });

      // Clear the text field after sending the message
      textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: Text(isMe ? widget.message.receiver!.fullname : widget.message.sender!.fullname),
        backgroundColor: Colors.green.shade200,
        actions: <Widget>[
          IconButton(
            key: iconKey,
            icon: const Icon(
              Icons.pending,
              color: _green,
            ),
            iconSize: 35,
            onPressed: () {
              final RenderBox iconRenderBox = iconKey.currentContext!.findRenderObject() as RenderBox;
              final iconPosition = iconRenderBox.localToGlobal(Offset.zero);
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  iconPosition.dx,
                  iconPosition.dy + iconRenderBox.size.height,
                  MediaQuery.of(context).size.width - iconPosition.dx - iconRenderBox.size.width,
                  MediaQuery.of(context).size.height - iconPosition.dy - iconRenderBox.size.height,
                ),
                items: [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.schedule_rounded, color: Colors.blue,),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.schedule_an_interview,),
                      ],
                    ),
                    onTap: () {
                      // Xử lý khi chọn Schedule an interview
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.cancel, color: Colors.red,),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.cancel,),
                      ],
                    ),
                    onTap: () {
                      // Xử lý khi chọn Cancel
                    },
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Đặt bán kính bo góc ở đây
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.green.shade200,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final Message message = messageList[index];
                    final bool isMyMessage = message.sender!.id == userId || message.receiver!.id == userId;
                    // Calculate the index in the reversed list
                    final reversedIndex = messageList.length - 1 - index;
                    return Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30,),
                            Center(child: Text(message.formattedCreatedAt(), style: const TextStyle(color: Colors.white)),),
                            const SizedBox(height: 8,),
                            Container(
                              alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), color: isMyMessage ? _green : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    message.content,
                                    style: TextStyle(color: isMyMessage ? Colors.white : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: _green),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            onPressed: (){
                              TimeChoosePopupFilter.show(context);
                            },
                            icon: const Icon(Icons.calendar_today_rounded, color: Colors.white,),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: textController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here...',
                                      hintStyle: TextStyle(color: Colors.white),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _sendMessage();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}



