import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/models/Interview.dart';
import 'package:studenthub/utils/socket_manager.dart';

const Color _green = Color(0xff296e48);

class UpdateInterviewPopUp extends StatefulWidget {
  final Interview interview;
  final int projectID;
  final int personID;
  final int meID;
  final Function refreshMessageList;
  const UpdateInterviewPopUp({Key? key, required this.interview, required this.projectID, required this.personID, required this.meID, required this.refreshMessageList})
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
    SocketManager.initializeSocket(context, widget.projectID);
    titleController.text = widget.interview.title;
  }

  void _updateInterview() {
    print(widget.interview.id);
    print(widget.projectID);
    print(widget.meID);
    print(widget.personID);
    print(updateInterview);
    print(widget.interview.startTime);
      SocketManager.updateInterview(
        widget.interview.id,
        widget.meID,
        widget.personID,
        widget.projectID,
        titleController.text,
        selectedStartDate!,
        selectedEndDate!,
        selectedStartTime!,
        selectedEndTime!,
        updateInterview
      );
    showSuccessDialog();
    widget.refreshMessageList();

  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.success, textAlign: TextAlign.center,),
          content: Text(AppLocalizations.of(context)!.update_interview_success, textAlign: TextAlign.center,),
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

  @override
  void dispose() {
    titleController.dispose();
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
                AppLocalizations.of(context)!.update_interview,
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
                  Text(
                    DateFormat('HH:mm, dd/MM/yyyy').format(widget.interview.startTime),
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
                  Text(
                    DateFormat('HH:mm, dd/MM/yyyy').format(widget.interview.endTime),
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
                    onPressed: (){_updateInterview();
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
    DateTime start = selectedStartDate ?? widget.interview.startTime;
    DateTime end = selectedEndDate ?? widget.interview.endTime;

    final startTime = DateTime(start.year, start.month, start.day, selectedStartTime?.hour ?? widget.interview.startTime.hour, selectedStartTime?.minute ?? widget.interview.startTime.minute);
    final endTime = DateTime(end.year, end.month, end.day, selectedEndTime?.hour ?? widget.interview.endTime.hour, selectedEndTime?.minute ?? widget.interview.endTime.minute);

    final difference = endTime.difference(startTime);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);

    setState(() {
      duration = '$hours hours $minutes';
    });
  }
}