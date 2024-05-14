import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ProposalDetailScreen extends StatefulWidget {
  const ProposalDetailScreen(
      {Key? key, required this.proposalId})
      : super(key: key);
  final int proposalId;

  @override
  ProjectDetailState createState() => ProjectDetailState();
}

class ProjectDetailState extends State<ProposalDetailScreen> {
  bool isLoading = false;
  Proposal? proposal;
  @override
  void initState() {
    super.initState();
    getProposal();
  }

  Future<void> getProposal() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        final response = await http.get(
          Uri.parse('http://34.16.137.128/api/proposal/${widget.proposalId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          if (jsonResponse['result'] != null) {
            setState(() {
              proposal = Proposal.fromJson(jsonResponse['result']);
            });
          } else {
            print('Response is not a proposal');
          }
        } else {
          print('Failed to get proposal: ${response.body}');
        }
      }
    } catch (error) {
      print('Failed to get proposal: $error');
      // Handle error cases here, show error message to user
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildProposalDetails();
  }

  Widget buildProposalDetails() {
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
                      proposal!.studentname!,
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
                                  proposal!.coverLetter),
                              _buildTableRow(
                                  context,
                                  AppLocalizations.of(context)!.techstack,
                                  proposal!.student!.techStack!.name),
                              _builArrayTableRow(
                                  context,
                                  AppLocalizations.of(context)!.education,
                                  proposal!.student!.educations!
                                      .map((skillSet) => skillSet.schoolName)
                                      .toList()),
                              _buildLinkTableRow(
                                  context,
                                  AppLocalizations.of(context)!.resume_CV,
                                  proposal!.resume ?? 'None', proposal!.resumeLink!),
                              _buildLinkTableRow(
                                  context,
                                  AppLocalizations.of(context)!.transcript,
                                  proposal!.transcript ?? 'None', proposal!.transcriptLink!),
                            ],
                          ),
                        )
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

  TableRow _builArrayTableRow(BuildContext context, String title, List<String> values) {
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

  TableRow _buildLinkTableRow(BuildContext context, String title, String name, String link) {
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
            child: InkWell(
              onTap: () => _handleLinkTap(link),
              child: Text(
                name.isNotEmpty ? name : 'None',
                style: TextStyle(
                  fontSize: 16,
                  color: name.isNotEmpty ? primaryColor : Colors.black,
                  decoration: name.isNotEmpty ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleLinkTap(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
