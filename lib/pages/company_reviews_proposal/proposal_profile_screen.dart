import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/models/Student.dart';

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ProposalDetailScreen extends StatefulWidget {
  const ProposalDetailScreen(
      {Key? key, required this.proposal, required this.student})
      : super(key: key);
  final Student student;
  final Proposal proposal;

  @override
  ProjectDetailState createState() => ProjectDetailState();
}

class ProjectDetailState extends State<ProposalDetailScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.proposal_detail,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.proposal.studentname!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(
                              10.0), // Bo góc của toàn bảng
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // Đẩy bóng ra ngoài
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(2), // Độ rộng cột 1
                              1: FlexColumnWidth(3), // Độ rộng cột 2
                            },
                            children: [
                              _buildTableRow(
                                  context,
                                  AppLocalizations.of(context)!.cover_letter,
                                  widget.proposal.coverLetter),
                              _buildTableRow(
                                  context,
                                  AppLocalizations.of(context)!.techstack,
                                  widget.student.techStack!.name),
                              _builArrayTableRow(
                                  context,
                                  AppLocalizations.of(context)!.education,
                                  widget.student.educations!
                                      .map((skillSet) => skillSet.schoolName)
                                      .toList()),
                              _buildTableRow(
                                  context,
                                  AppLocalizations.of(context)!.resume_CV,
                                  widget.student.resume ?? 'None'),
                              _buildTableRow(
                                  context,
                                  AppLocalizations.of(context)!.transcript,
                                  widget.student.transcript ?? 'None'),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(BuildContext context, String title, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _builArrayTableRow(
      BuildContext context, String title, List<String> values) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: values.isNotEmpty
                  ? values.map((value) => Text(value)).toList()
                  : [
                      const Text(
                        'None',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
            ),
          ),
        ),
      ],
    );
  }
}
