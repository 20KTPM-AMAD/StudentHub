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
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.cover_letter,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        Text(
                          widget.coverLetter,
                          style: const TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                          Text(
                            AppLocalizations.of(context)!.techstack,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          Text(
                            widget.techStackName,
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.skillset,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        const Text(
                          'None',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.education,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        const Text(
                          'None',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.experiences,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        const Text(
                          'None',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.resume_CV,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        const Text(
                          'None',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.transcript,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        const Text(
                          'None',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}