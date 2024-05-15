import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/company_reviews_proposal/proposal_profile_screen.dart';
import 'package:studenthub/pages/student_submit_proposal/student_project_detail_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xFF12B28C);

class OfferNotificationCard extends StatefulWidget {
  final NotificationItem notification;
  const OfferNotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  OfferNotificationCardState createState() => OfferNotificationCardState();
}

class OfferNotificationCardState extends State<OfferNotificationCard> {
  @override
  void initState() {
    super.initState();
    inspect(widget.notification.proposal);
  }

  Future<void> readNoti() async {
    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        final response = await http.patch(
          Uri.parse(
              'https://api.studenthub.dev/api/notification/readNoti/${widget.notification.id}'),
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
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/settings.png',
                    fit: BoxFit.cover, width: 50, height: 50),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.offer_notification(
                            widget.notification.proposal != null &&
                                    widget.notification.proposal!.project !=
                                        null
                                ? widget.notification.proposal!.project!.title
                                : ''),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Số dòng tối đa
                      ),
                      Text(
                        DateFormat('HH:mm, dd/MM/yyyy').format(widget
                            .notification.createdAt
                            .add(const Duration(hours: 7))),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      widget.notification.proposal != null
                          ? SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentProjectDetailScreen(
                                                  id: widget.notification
                                                      .proposal!.project!.id,
                                                  isOffer: widget
                                                          .notification
                                                          .proposal!
                                                          .statusFlag ==
                                                      2,
                                                  proposalId: widget
                                                      .notification
                                                      .proposal!
                                                      .id)));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: _green,
                                    foregroundColor: Colors.white),
                                child: Text(
                                    AppLocalizations.of(context)!.view_offer,
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          readNoti();
        },
      ),
    );
  }
}
