import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/models/Message.dart';
import 'package:studenthub/pages/chat/video_call_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class ScheduleInterviewMessageCard extends StatelessWidget {
  final Message message;
  ScheduleInterviewMessageCard({Key? key, required this.message}) : super(key: key);

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
                  AppLocalizations.of(context)!.schedule_interview('Alex Xu'),
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  message.scheduleInterview!.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                Text(
                  '${message.scheduleInterview!.endTime.difference(message.scheduleInterview!.startTime).inMinutes} minutes',
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  DateFormat('kk:mm dd/MM/yyyy').format(message.scheduleInterview!.startTime),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(width: 10),
                const Text('-'),
                const SizedBox(width: 10),
                Text(
                  DateFormat('kk:mm dd/MM/yyyy').format(message.scheduleInterview!.endTime),
                  style: const TextStyle(fontStyle: FontStyle.italic),
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
                      MaterialPageRoute(builder: (context) => VideoCallScreen()),
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
                            // Xử lý khi chọn Edit
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
                          onTap: () {
                            // Xử lý khi chọn Delete
                          },
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Đặt bán kính bo góc ở đây
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