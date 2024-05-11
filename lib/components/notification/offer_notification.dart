import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/models/Notification.dart';
import 'package:studenthub/pages/company_reviews_proposal/proposal_profile_screen.dart';

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
                                            ProposalDetailScreen(
                                                fullname: widget.notification
                                                    .proposal!.studentname!,
                                                coverLetter: widget.notification
                                                    .proposal!.coverLetter,
                                                techStackName: widget
                                                            .notification
                                                            .proposal!
                                                            .student!
                                                            .techStack !=
                                                        null
                                                    ? widget
                                                        .notification
                                                        .proposal!
                                                        .student!
                                                        .techStack!
                                                        .name
                                                    : '')),
                                  );
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
        onTap: () {},
      ),
    );
  }
}
