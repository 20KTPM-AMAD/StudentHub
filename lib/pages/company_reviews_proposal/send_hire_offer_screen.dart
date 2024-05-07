import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:studenthub/components/company_project/tab_detail.dart';
import 'package:studenthub/components/company_project/tab_message.dart';
import 'package:studenthub/components/company_project/tab_proposal_hired.dart';
import 'package:studenthub/components/company_project/tab_proposals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/models/Project.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studenthub/utils/auth_provider.dart';

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class SendHireOfferScreen extends StatefulWidget {
  const SendHireOfferScreen({Key? key, required this.projectId})
      : super(key: key);

  final int projectId;

  @override
  SendHireOfferState createState() => SendHireOfferState();
}

class SendHireOfferState extends State<SendHireOfferScreen> {
  String title = '';

  @override
  void initState() {
    super.initState();
    getTitleProject();
  }

  Future<void> getTitleProject() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://34.16.137.128/api/project/${widget.projectId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        setState(() {
          final project = Project.fromJson(jsonResponse['result']);
          title = project.title;
        });
      } else {
        print('Failed to get list project: ${response.body}');
        // Handle error cases here, show error message to user
      }
    }
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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: primaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTabController(
                      length: 4,
                      child: Column(
                        children: [
                          TabBar(tabs: [
                            Tab(
                              text: AppLocalizations.of(context)!.proposals,
                            ),
                            Tab(
                              text: AppLocalizations.of(context)!.detail,
                            ),
                            Tab(
                              text: AppLocalizations.of(context)!.message,
                            ),
                            Tab(
                              text: AppLocalizations.of(context)!.hired,
                            ),
                          ]),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                kToolbarHeight -
                                200,
                            child: TabBarView(
                              children: [
                                ProposalsTab(projectId: widget.projectId),
                                DetailTab(projectId: widget.projectId,),
                                MessageListTab(projectId: widget.projectId),
                                ProposalsHiredTab(projectId: widget.projectId)
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
