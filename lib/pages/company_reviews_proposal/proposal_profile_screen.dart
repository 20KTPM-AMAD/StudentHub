import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/pages/student_submit_proposal/submit_proposal.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ProposalDetailScreen extends StatefulWidget {
  const ProposalDetailScreen({Key? key, required this.fullname, required this.coverLetter, required this.techStackName}) : super(key: key);
  final String fullname, coverLetter, techStackName;

  @override
  ProjectDetailState createState() => ProjectDetailState();
}

class ProjectDetailState extends State<ProposalDetailScreen>{
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    Text(
                      AppLocalizations.of(context)!.proposal_detail,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      widget.fullname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Divider(),
                    const SizedBox(height: 50,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10.0), // Bo góc của toàn bảng
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Đẩy bóng ra ngoài
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2), // Độ rộng cột 1
                            1: FlexColumnWidth(3), // Độ rộng cột 2
                          },
                          children: [
                            _buildTableRow(context, AppLocalizations.of(context)!.cover_letter, widget.coverLetter),
                            _buildTableRow(context, AppLocalizations.of(context)!.techstack, widget.techStackName),
                            _buildTableRow(context, AppLocalizations.of(context)!.skillset, 'None'),
                            _buildTableRow(context, AppLocalizations.of(context)!.education, 'None'),
                            _buildTableRow(context, AppLocalizations.of(context)!.experiences, 'None'),
                            _buildTableRow(context, AppLocalizations.of(context)!.resume_CV, 'None'),
                            _buildTableRow(context, AppLocalizations.of(context)!.transcript, 'None'),
                          ],
                        ),)
                    )
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

}