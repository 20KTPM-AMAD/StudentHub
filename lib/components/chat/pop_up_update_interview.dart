import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Interview.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/socket_manager.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class UpdateInterviewPopUp extends StatefulWidget {
  final Interview interview;
  final int projectID;
  final int personID;
  final int meID;
  final Function refreshMessageList;
  const UpdateInterviewPopUp(
      {Key? key,
      required this.interview,
      required this.projectID,
      required this.personID,
      required this.meID,
      required this.refreshMessageList})
      : super(key: key);

  @override
  UpdateInterviewPopUpState createState() => UpdateInterviewPopUpState();
}

class UpdateInterviewPopUpState extends State<UpdateInterviewPopUp> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String? startTimeFormat;
  String? endTimeFormat;
  String? duration;
  bool updateInterview = true;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController!.text = widget.interview.title;
  }

  Future<void> _updateInterview() async {
    final String? token =
        Provider.of<AuthProvider>(context, listen: false).token;

    String newTitle = titleController.text;
    DateTime newStartTime = DateTime.utc(
      selectedStartDate?.year ?? widget.interview.startTime.year,
      selectedStartDate?.month ?? widget.interview.startTime.month,
      selectedStartDate?.day ?? widget.interview.startTime.day,
      selectedStartTime?.hour ?? widget.interview.startTime.hour,
      selectedStartTime?.minute ?? widget.interview.startTime.minute,
    );
    DateTime newEndTime = DateTime.utc(
      selectedEndDate?.year ?? widget.interview.endTime.year,
      selectedEndDate?.month ?? widget.interview.endTime.month,
      selectedEndDate?.day ?? widget.interview.endTime.day,
      selectedEndTime?.hour ?? widget.interview.endTime.hour,
      selectedEndTime?.minute ?? widget.interview.endTime.minute,
    );

    bool isTitleChanged = newTitle != widget.interview.title;
    bool isStartTimeChanged =
        newStartTime.toUtc() != widget.interview.startTime;
    bool isEndTimeChanged = newEndTime.toUtc() != widget.interview.endTime;

    if (isTitleChanged || isStartTimeChanged || isEndTimeChanged) {
      Map<String, dynamic> newData = {
        if (isTitleChanged) 'title': newTitle,
        if (isStartTimeChanged) 'startTime': newStartTime.toIso8601String(),
        if (isEndTimeChanged) 'endTime': newEndTime.toIso8601String(),
      };

      final response = await http.patch(
        Uri.parse(
            'https://api.studenthub.dev/api/interview/${widget.interview.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(newData),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        showSuccessDialog();
        widget.refreshMessageList();
      } else {
        print('Failed to update interview:  ${response.body}');
      }
    } else {
      print('No changes detected. No update required.');
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.success,
            textAlign: TextAlign.center,
          ),
          content: Text(
            AppLocalizations.of(context)!.update_interview_success,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    titleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
              child: Text(
                AppLocalizations.of(context)!.update_interview,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                  const SizedBox(
                    height: 5,
                  ),
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
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
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
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      IconButton(
                        onPressed: () async {
                          final DateTime? selectedDate =
                              await selectDate(context);
                          final TimeOfDay? selectedTime =
                              await selectTime(context);
                          if (selectedDate != null && selectedTime != null) {
                            setState(() {
                              selectedStartDate = selectedDate;
                              selectedStartTime = selectedTime;
                              startTimeFormat =
                                  '${DateFormat('yyyy/MM/dd').format(selectedStartDate!)} ${selectedStartTime!.format(context)}';
                              calculateDuration();
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      IconButton(
                        onPressed: () async {
                          final TimeOfDay? selectedTime =
                              await selectTime(context);
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
                  Text(
                    startTimeFormat ??
                        DateFormat('HH:mm, dd/MM/yyyy')
                            .format(widget.interview.startTime),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
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
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      IconButton(
                        onPressed: () async {
                          final DateTime? selectedDate =
                              await selectDate(context);
                          final TimeOfDay? selectedTime =
                              await selectTime(context);
                          if (selectedDate != null && selectedTime != null) {
                            setState(() {
                              selectedEndDate = selectedDate;
                              selectedEndTime = selectedTime;
                              endTimeFormat =
                                  '${DateFormat('yyyy/MM/dd').format(selectedEndDate!)} ${selectedEndTime!.format(context)}';
                              calculateDuration();
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      IconButton(
                        onPressed: () async {
                          final TimeOfDay? selectedTime =
                              await selectTime(context);
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
                  Text(
                    endTimeFormat ??
                        DateFormat('HH:mm, dd/MM/yyyy')
                            .format(widget.interview.endTime),
                    style: const TextStyle(fontStyle: FontStyle.italic),
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
                        fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
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
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(fontSize: 14)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateInterview();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _green, foregroundColor: Colors.white),
                    child: Text(
                        AppLocalizations.of(context)!.update_interview_btn,
                        style: const TextStyle(fontSize: 14)),
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
    DateTime start = selectedStartDate ?? widget.interview.startTime;
    DateTime end = selectedEndDate ?? widget.interview.endTime;

    final startTime = DateTime(
        start.year,
        start.month,
        start.day,
        selectedStartTime?.hour ?? widget.interview.startTime.hour,
        selectedStartTime?.minute ?? widget.interview.startTime.minute);
    final endTime = DateTime(
        end.year,
        end.month,
        end.day,
        selectedEndTime?.hour ?? widget.interview.endTime.hour,
        selectedEndTime?.minute ?? widget.interview.endTime.minute);

    final difference = endTime.difference(startTime);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);

    setState(() {
      duration = '$hours hours $minutes';
    });
  }
}
