import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/socket_manager.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class TimeChoosePopupFilter extends StatefulWidget {
  final int personID;
  final int projetcID;
  final int meID;
  final Function refreshMessageList;
  const TimeChoosePopupFilter({Key? key, required this.personID, required this.projetcID, required this.meID, required this.refreshMessageList})
      : super(key: key);

  @override
  TimeChoosePopupFilterState createState() => TimeChoosePopupFilterState();
}

class TimeChoosePopupFilterState extends State<TimeChoosePopupFilter> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String? startTimeFormat;
  String? endTimeFormat;
  String? duration;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  int userId = 0;

  @override
  void initState() {
    super.initState();
    SocketManager.initializeSocket(context, widget.projetcID);
  }

  Future<void> _createInterview() async {
    final String? token = Provider.of<AuthProvider>(context, listen: false).token;
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields must not empty'),
          backgroundColor: Colors.red,
        ),
      );
    }

    DateTime startDateTime = DateTime(selectedStartDate!.year, selectedStartDate!.month, selectedStartDate!.day, selectedStartTime!.hour, selectedStartTime!.minute);
    DateTime endDateTime = DateTime(selectedEndDate!.year, selectedEndDate!.month, selectedEndDate!.day, selectedEndTime!.hour, selectedEndTime!.minute);

    String meetingRoomCode = generateRandomString(10);
    String meetingRoomId = generateRandomString(10);
    bool retry = true;
    while (retry) {
      final response = await http.post(
        Uri.parse('https://api.studenthub.dev/api/interview'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'title': titleController.text,
          'content': contentController.text,
          'startTime': startDateTime.toIso8601String(),
          'endTime': endDateTime.toIso8601String(),
          'projectId': widget.projetcID,
          'senderId': widget.meID,
          'receiverId': widget.personID,
          'meeting_room_code': meetingRoomCode,
          'meeting_room_id': meetingRoomId
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        showSuccessDialog();
        widget.refreshMessageList();
        retry = false;
      } else {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['errorDetails'].contains("Meeting room code already exists") || jsonResponse['errorDetails'].contains("Meeting room code already exists")){
          meetingRoomCode = generateRandomString(10);
          meetingRoomId = generateRandomString(10);
        } else {
          showFailDialog();
          retry = false;
        }
      }
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.success),
          content: Text(AppLocalizations.of(context)!.create_interview_success),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK', textAlign: TextAlign.center,),
            ),
          ],
        );
      },
    );
  }

  void showFailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.fail),
          content: Text(AppLocalizations.of(context)!.fail_create_interview),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK', textAlign: TextAlign.center,),
            ),
          ],
        );
      },
    );
  }

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
              child: Text(
                AppLocalizations.of(context)!.schedule_video_call,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.title_interview,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_title,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: _green),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    AppLocalizations.of(context)!.content,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_content,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: _green),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.start_time,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.choose_start_time,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final DateTime? selectedDate = await selectDate(context);
                          final TimeOfDay? selectedTime = await selectTime(context);
                          if (selectedDate != null && selectedTime != null) {
                            setState(() {
                              selectedStartDate = selectedDate;
                              selectedStartTime = selectedTime;
                              startTimeFormat = '${DateFormat('yyyy/MM/dd').format(selectedStartDate!)} ${selectedStartTime!.format(context)}';
                              calculateDuration();
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      IconButton(
                        onPressed: () async {
                          final TimeOfDay? selectedTime = await selectTime(context);
                          if (selectedTime != null) {
                            setState(() {
                              selectedStartTime = selectedTime;
                            });
                          }
                        },
                        icon: const Icon(Icons.timer_outlined),
                      )
                    ],
                  ),
                  if (startTimeFormat != null)
                    Text(
                      startTimeFormat!,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.end_time,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.choose_end_time,
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final DateTime? selectedDate = await selectDate(context);
                          final TimeOfDay? selectedTime = await selectTime(context);
                          if (selectedDate != null && selectedTime != null) {
                            setState(() {
                              selectedEndDate = selectedDate;
                              selectedEndTime = selectedTime;
                              endTimeFormat = '${DateFormat('yyyy/MM/dd').format(selectedEndDate!)} ${selectedEndTime!.format(context)}';
                              calculateDuration();
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      IconButton(
                        onPressed: () async {
                          final TimeOfDay? selectedTime = await selectTime(context);
                          if (selectedTime != null) {
                            setState(() {
                              selectedEndTime = selectedTime;
                            });
                          }
                        },
                        icon: const Icon(Icons.timer_outlined),
                      )
                    ],
                  ),
                  if (endTimeFormat != null)
                    Text(
                      endTimeFormat!,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.duration(duration ?? '0'),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(fontSize: 14)),
                  ),
                  ElevatedButton(
                    onPressed: (){_createInterview();
                      },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white
                    ),
                    child: Text(AppLocalizations.of(context)!.send_invite, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  void calculateDuration() {
    if (selectedStartDate != null && selectedStartTime != null && selectedEndDate != null && selectedEndTime != null) {
      final startTime = DateTime(selectedStartDate!.year, selectedStartDate!.month, selectedStartDate!.day, selectedStartTime!.hour, selectedStartTime!.minute);
      final endTime = DateTime(selectedEndDate!.year, selectedEndDate!.month, selectedEndDate!.day, selectedEndTime!.hour, selectedEndTime!.minute);
      final difference = endTime.difference(startTime);
      final hours = difference.inHours;
      final minutes = difference.inMinutes.remainder(60);
      setState(() {
        duration = '$hours hours $minutes';
      });
    } else {
      setState(() {
        duration = '';
      });
    }
  }
}