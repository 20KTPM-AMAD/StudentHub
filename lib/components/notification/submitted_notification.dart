import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/company_reviews_proposal/proposal_profile_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xFF12B28C);

class SubmittedNotificationCard extends StatefulWidget {
  final NotificationItem notification;
  const SubmittedNotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  SubmittedNotificationCardState createState() =>
      SubmittedNotificationCardState();
}

class SubmittedNotificationCardState extends State<SubmittedNotificationCard> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> readNoti() async {
    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        final response = await http.patch(
          Uri.parse('https://api.studenthub.dev/api/notification/readNoti/${widget.notification.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.notification.notifyFlag == "0" ? Colors.green.shade200 : Colors.green.shade50,
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/user.png',
                    fit: BoxFit.cover, width: 50, height: 50),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.notification.proposal != null
                              ? AppLocalizations.of(context)!
                                  .submitted_notification(
                                      widget.notification.proposal!.project !=
                                              null
                                          ? widget.notification.proposal!
                                              .project!.title
                                          : '',
                                      widget.notification.sender.fullname)
                              : AppLocalizations.of(context)!
                                  .submitted_notification('1', '2'),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3),
                      Text(
                        DateFormat('HH:mm, dd/MM/yyyy').format(widget
                            .notification.createdAt
                            .add(const Duration(hours: 7))),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProposalDetailScreen(
                                      proposalId: widget.notification.proposal!.id,)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.white),
                        child: Text(AppLocalizations.of(context)!.view,
                            style: const TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {readNoti();},
      ),
    );
  }
}
