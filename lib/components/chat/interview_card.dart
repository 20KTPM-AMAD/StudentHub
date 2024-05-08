import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Interview.dart';
import 'package:studenthub/pages/chat/message_detail_screen.dart';
import 'package:studenthub/pages/chat/zego/zego.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xff296e48);

class InterviewCard extends StatefulWidget {
  const InterviewCard({Key? key}) : super(key: key);

  @override
  State<InterviewCard> createState() => _InterviewCardState();
}

class _InterviewCardState extends State<InterviewCard> {
  bool isLoading = false;
  List<Interview> interviews = [];
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
          Uri.parse('https://api.studenthub.dev/api/interview/user/$userId'),
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
              interviews = (jsonResponse['result'] as List).map((data) => Interview.fromJson(data)).toList();
            });
          }
        }
      }
    } catch (error) {
      print('Failed to get list interview: $error');
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
        itemCount: interviews.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        itemBuilder: (context, index){
          if (interviews.isEmpty) {
            return const Center(
              child: Text('There are currently no interview'),
            );
          }
          final interview = interviews[index];
          return Card(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoCallPage(conferenceID: interview.meetingRoom!.meetingRoomCode,)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                child: Row(
                  children: [
                    Image.asset('assets/images/interview.png', fit: BoxFit.cover, width: 50, height: 50),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  interview.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: _green
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.start_time}: ${interview.formattedStartTime()}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.end_time}: ${interview.formattedEndTime()}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.meeting_room_id}: ${interview.meetingRoom!.meetingRoomId}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.meeting_room_code}: ${interview.meetingRoom!.meetingRoomCode}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20,)
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
