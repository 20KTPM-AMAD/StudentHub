import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/pages/student_submit_proposal/student_project_detail_screen.dart';

const Color _green = Color(0xff296e48);

class StudentProjectDetailCard extends StatefulWidget {
  StudentProjectDetailCard({Key? key, required this.proposal, bool? isActive})
      : isActive = isActive ?? false,
        super(key: key);

  final Proposal proposal;
  final bool isActive;

  @override
  State<StudentProjectDetailCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<StudentProjectDetailCard> {
  late final Proposal proposal;

  String _getTimeElapsed(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return AppLocalizations.of(context)!
          .submitted_days_ago(difference.inDays);
    } else if (difference.inHours > 0) {
      return AppLocalizations.of(context)!
          .submitted_hours_ago(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return AppLocalizations.of(context)!
          .submitted_minutes_ago(difference.inMinutes);
    } else {
      return AppLocalizations.of(context)!.just_now;
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      proposal = widget.proposal;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (proposal.project == null) {
      return const SizedBox();
    }

    return Card(
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    proposal.project!.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: _green,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            Text(
              _getTimeElapsed(proposal.createdAt),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Students are looking for:\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  WidgetSpan(
                    child: MarkdownBody(
                      data: proposal.project!.description,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            widget.isActive &&
                    proposal.statusFlag.toString() ==
                        StatusFlag.Offer.index.toString()
                ? Text('You have OFFER')
                : SizedBox()
          ],
        ),
        onTap: () async {
          if (widget.isActive &&
              proposal.statusFlag.toString() ==
                  StatusFlag.Offer.index.toString()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentProjectDetailScreen(
                      id: proposal.project!.id,
                      isOffer: true,
                      proposalId: proposal.id)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      StudentProjectDetailScreen(id: proposal.project!.id)),
            );
          }
        },
      ),
    );
  }
}
