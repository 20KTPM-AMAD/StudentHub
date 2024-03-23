import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
const Color _green = Color(0xFF12B28C);

class StudentProjectDetailCard extends StatefulWidget {
  const StudentProjectDetailCard(
      {Key? key})
      : super(key: key);

  @override
  State<StudentProjectDetailCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<StudentProjectDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Senior frontend developer (Fintech)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: _green,
                    ),
                    overflow: TextOverflow.ellipsis, // Hiển thị dấu ... khi văn bản tràn ra ngoài
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),

            Text(
              AppLocalizations.of(context)!.time_created_project('3'),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.time_needed_project('1-3') + AppLocalizations.of(context)!.student_needed_project('6'),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Students are looking for:\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '- Clear expectation about your project or deliverables',
                    style: TextStyle(
                      fontSize: 16, // Cỡ chữ
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${AppLocalizations.of(context)!.proposals}: Less than 5',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: () {
        },
      ),
    );
  }
}
