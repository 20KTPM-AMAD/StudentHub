import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/chat/pop_up_time_choose.dart';
import 'package:studenthub/components/chat/schedule_interview_message.dart';
import 'package:studenthub/models/Message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/utils/socket_manager.dart';

const Color _green = Color(0xff296e48);

class MessageDetailScreen extends StatefulWidget {
  final int personID;
  final int projectID;
  final String personFullName;

  const MessageDetailScreen(
      {Key? key,
      required this.personID,
      required this.personFullName,
      required this.projectID})
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
    connectSocket();
    getMessageList();
  }

  @override
  void dispose() {
    SocketManager().unregisterSocketListener(onReceiveNotification);
    super.dispose();
  }

  Future<void> connectSocket() async {
    final loginUser =
        Provider.of<AuthProvider>(context, listen: false).loginUser;

    if (loginUser != null) {
      final socketManager = SocketManager();
      SocketManager().registerSocketListener(onReceiveNotification);

      await socketManager.connectSocket(context, loginUser.id);
    }
  }

  void onReceiveNotification(data) {
    if (data['notification'] != null) {
      if (data['notification']['typeNotifyFlag'] == '3') {
        final notification = NotificationItem.fromJson(data['notification']);
        final message = Message.fromJson(data['notification']['message']);
        message.sender = notification.sender;
        message.receiver = notification.receiver;
        if (message.projectId == widget.projectID &&
            (message.sender.id == userId || message.receiver.id == userId)) {
          setState(() {
            messageList.insert(0, message);
          });
        }
        return;
      }
      if (data['notification']['typeNotifyFlag'] == '1') {
        final notification = NotificationItem.fromJson(data['notification']);
        final message = Message.fromJson(data['notification']['message']);
        message.sender = notification.sender;
        message.receiver = notification.receiver;
        if (message.projectId == widget.projectID &&
            (message.sender.id == userId || message.receiver.id == userId)) {
          setState(() {
            messageList.insert(0, message);
          });
        }
        return;
      }
    }
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
          Uri.parse(
              'https://api.studenthub.dev/api/message/${widget.projectID}/user/${widget.personID}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        print(
            'https://api.studenthub.dev/api/message/${widget.projectID}/user/${widget.personID}');

        print(response.statusCode);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          if (jsonResponse['result'] is List) {
            setState(() {
              messageList = jsonResponse['result']
                  .map<Message>((data) => Message.fromJson(data))
                  .toList();
              messageList = messageList.reversed.toList();
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

  Future<void> sendMessage() async {
    final String? token =
        Provider.of<AuthProvider>(context, listen: false).token;
    if (textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Message must not empty',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    print(userId);
    print(widget.personID);
    final response = await http.post(
      Uri.parse('https://api.studenthub.dev/api/message/sendMessage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'projectId': widget.projectID,
        'content': textController.text,
        'messageFlag': 0,
        'senderId': userId,
        'receiverId': widget.personID
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 201) {
      Message newMessage = Message(
        id: messageList.length + 1,
        createdAt: DateTime.now(),
        content: textController.text,
        sender: Postman(id: userId, fullname: 'sender'),
        receiver: Postman(id: widget.personID, fullname: widget.personFullName),
        project: null,
        projectId: widget.projectID,
      );

      setState(() {
        messageList.insert(0, newMessage);
      });
      textController.clear();
    } else {
      print('Failed to send message:  ${response.body}');
    }
  }

  void refreshMessageList() {
    getMessageList();
  }

  @override
  Widget build(BuildContext context) {
    final iconKey = GlobalKey();

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: Image.asset('assets/images/human.png').image,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.personFullName),
            ],
          ),
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
                final RenderBox iconRenderBox =
                    iconKey.currentContext!.findRenderObject() as RenderBox;
                final iconPosition = iconRenderBox.localToGlobal(Offset.zero);
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    iconPosition.dx,
                    iconPosition.dy + iconRenderBox.size.height,
                    MediaQuery.of(context).size.width -
                        iconPosition.dx -
                        iconRenderBox.size.width,
                    MediaQuery.of(context).size.height -
                        iconPosition.dy -
                        iconRenderBox.size.height,
                  ),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.schedule_an_interview,
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return TimeChoosePopupFilter(
                                personID: widget.personID,
                                projetcID: widget.projectID,
                                meID: userId,
                                refreshMessageList: refreshMessageList);
                          },
                        );
                      },
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.cancel,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
                  reverse: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final Message message = messageList[index];
                    final bool isMyMessage = message.sender!.id == userId;
                    return Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: isMyMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              alignment: isMyMessage
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: isMyMessage
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  if (!isMyMessage)
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          Image.asset('assets/images/human.png')
                                              .image,
                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: isMyMessage
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      if (message.content !=
                                          'Interview created')
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: isMyMessage
                                                ? _green
                                                : Colors.white,
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    message.content!,
                                                    style: TextStyle(
                                                      color: isMyMessage
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      if (message.content !=
                                          'Interview created')
                                        Text(
                                          message.formattedCreatedAt(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (message.interview != null)
                              ScheduleInterviewMessageCard(
                                message: message,
                                personID: widget.personID,
                                projetcID: widget.projectID,
                                meID: userId,
                                refreshMessageList: refreshMessageList,
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TimeChoosePopupFilter(
                                      personID: widget.personID,
                                      projetcID: widget.projectID,
                                      meID: userId,
                                      refreshMessageList: refreshMessageList);
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white,
                            ),
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
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)!
                                          .type_your_message_here,
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    sendMessage();
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
        ));
  }
}
