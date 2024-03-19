import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class SubmittedNotificationCard extends StatefulWidget {
  const SubmittedNotificationCard({Key? key}) : super(key: key);

  @override
  SubmittedNotificationCardState createState() => SubmittedNotificationCardState();
}

class SubmittedNotificationCardState extends State<SubmittedNotificationCard> {
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
                const Icon(Icons.person_rounded, size: 40),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.submitted_notification('Javis - AI Copilot'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Số dòng tối đa
                      ),
                      Text(
                        '6/6/2024',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
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