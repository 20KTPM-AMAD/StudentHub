import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/chat/pop_up_time_choose.dart';
import 'package:studenthub/components/chat/schedule_interview_message.dart';
import 'package:studenthub/models/Message.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/models/ScheduleInterview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/socket_manager.dart';

const Color _green = Color(0xff296e48);

class MessageDetailScreen extends StatefulWidget {
  final int personID;
  final int projetcID;
  final String personFullName;

  const MessageDetailScreen({Key? key, required this.personID, required this.personFullName, required this.projetcID})
      : super(key: key);

  @override
  State<MessageDetailScreen> createState() => MessageDetailScreenState();
}

class MessageDetailScreenState extends State<MessageDetailScreen> {
  bool isLoading = false;
  List<Message> messageList = [];
  List<String> messages = [];
  int userId = 0;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SocketManager.initializeSocket(context, widget.projetcID);
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

      if (token != null) {
        final response = await http.get(
          Uri.parse('https://api.studenthub.dev/api/message/${widget.projetcID}/user/${widget.personID}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print('https://api.studenthub.dev/api/message/${widget.projetcID}/user/${widget.personID}');

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
        widget.projetcID,
        userId,
        widget.personID,
      );

      Message newMessage = Message(
        id: messageList.length + 1,
        createdAt: DateTime.now(),
        content: messageContent,
        sender: Postman(id: userId, fullname: 'sender'),
        receiver: Postman(id: widget.personID, fullname: 'receiver'),
        project: Project(1, 1, 'title', 'description', 0, 0, 0, DateTime.now(), DateTime.now(), null, 0, 0, 0, false),
      );

      setState(() {
        messageList.add(newMessage);
      });
      textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personFullName),
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
                    final bool isMyMessage = message.sender!.id == userId;
                    return Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30,),
                            Center(child: Text(message.formattedCreatedAt(), style: const TextStyle(color: Colors.white)),),
                            const SizedBox(height: 8,),
                            Container(
                              alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), color: isMyMessage ? _green : Colors.white,),
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
                            alignment: Alignment.center,
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



