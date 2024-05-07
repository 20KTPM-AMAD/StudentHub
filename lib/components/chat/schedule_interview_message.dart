import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/chat/pop_up_time_choose.dart';
import 'package:studenthub/components/chat/pop_up_update_interview.dart';
import 'package:studenthub/models/Message.dart';
import 'package:studenthub/pages/chat/video_call_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/pages/chat/zego/zego.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/socket_manager.dart';
import 'package:http/http.dart' as http;


const Color _green = Color(0xff296e48);

class ScheduleInterviewMessageCard extends StatefulWidget {
  final Message message;
  final int personID;
  final int projetcID;
  final int meID;
  final Function refreshMessageList;

  const ScheduleInterviewMessageCard({Key? key, required this.message, required this.personID, required this.projetcID, required this.meID, required this.refreshMessageList})
      : super(key: key);

  @override
  State<ScheduleInterviewMessageCard> createState() => ScheduleInterviewMessageCardState();
}

class ScheduleInterviewMessageCardState extends State<ScheduleInterviewMessageCard> {

  bool cancelMeeting = true;

  void initState() {
    super.initState();
    SocketManager.initializeSocket(context, widget.projetcID);
  }

  Future<void> _cancelInterview() async {
    print(widget.message.interview!.id);
    print(widget.projetcID);
    print(widget.meID);
    print(widget.personID);
    print(cancelMeeting);

    final String? token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.patch(
      Uri.parse('https://api.studenthub.dev/api/interview/${widget.message.interview!.id}/disable'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      showSuccessDialog();
      widget.refreshMessageList();
    } else {
      print('Failed to cancel interview:  ${response.body}');
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.success, textAlign: TextAlign.center,),
          content: Text(AppLocalizations.of(context)!.cancel_interview_success, textAlign: TextAlign.center,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', textAlign: TextAlign.center,),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey iconKey = GlobalKey();

    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.schedule_interview(widget.message.sender.fullname),
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  widget.message.interview!.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                Text(
                  '${widget.message.interview!.endTime.difference(widget.message.interview!.startTime).inMinutes} minutes',
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  DateFormat('kk:mm dd/MM/yyyy').format(widget.message.interview!.startTime),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(width: 10),
                const Text('-'),
                const SizedBox(width: 10),
                Text(
                  DateFormat('kk:mm dd/MM/yyyy').format(widget.message.interview!.endTime),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.meeting_room_code,
                      style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.message.interview!.meetingRoom!.meetingRoomCode,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.meeting_room_id,
                      style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.message.interview!.meetingRoom!.meetingRoomId,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                    if (widget.message.interview!.disableFlag == 0)
                      const Text(
                        'Active',
                        style: TextStyle(fontStyle: FontStyle.italic, color: _green),
                      )
                    else
                      const Text(
                        'Cancel',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
                      )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoCallPage(conferenceID: widget.message.interview!.meetingRoom!.meetingRoomCode,)),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.join),
                ),
                const SizedBox(height: 10),
                IconButton(
                  key: iconKey,
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
                              Text(AppLocalizations.of(context)!.reschedule_meeting),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return UpdateInterviewPopUp(
                                  interview: widget.message.interview!,
                                  projectID: widget.projetcID,
                                  personID: widget.personID,
                                  meID: widget.meID,
                                  refreshMessageList: widget.refreshMessageList,);
                              },
                            );
                          },
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              const Icon(Icons.cancel, color: Colors.red,),
                              const SizedBox(width: 8),
                              Text(AppLocalizations.of(context)!.cancel_meeting),
                            ],
                          ),
                          onTap: () {_cancelInterview();},
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                  icon: const Icon(Icons.pending_outlined, size: 30),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}