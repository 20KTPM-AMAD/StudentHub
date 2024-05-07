import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

class StudentProjectDetailScreen extends StatefulWidget {
  StudentProjectDetailScreen({
    Key? key,
    required this.id,
    bool? isOffer,
    int? proposalId,
  })  : isOffer = isOffer ?? false,
        proposalId =
            isOffer != null && isOffer ? (proposalId ?? 0) : (proposalId ?? -1),
        super(key: key);

  final int id;

  final bool isOffer;

  final int proposalId;

  @override
  StudentProjectDetailState createState() => StudentProjectDetailState();
}

class StudentProjectDetailState extends State<StudentProjectDetailScreen> {
  late Project project;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    try {
      final currentProject = await getProjectById(widget.id, token!);
      setState(() {
        project = currentProject;
      });
    } catch (error) {
      print('Error fetching project: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> update() async {
    try {
      final String? token = Provider.of<AuthProvider>(context, listen: false).token;

      await updateProposal(
          widget.proposalId, StatusFlag.Hired.index, token);
    } catch (error) {
      print(error);
    }
  }

  String getProjectScopeFormart(int projectScope) {
    if (projectScope == 0) {
      return AppLocalizations.of(context)!
          .time_needed_project('Less than one month');
    } else if (projectScope == 1) {
      return AppLocalizations.of(context)!.time_needed_project('1-3');
    } else if (projectScope == 2) {
      return AppLocalizations.of(context)!.time_needed_project('3-6');
    } else {
      return AppLocalizations.of(context)!
          .time_needed_project('More than 6 months');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildProject();
  }

  Widget buildProject() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/project_detail.png',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.project_detail,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.project_name}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: _green,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.3),
                                  child: Text(
                                    project.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: _green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.company}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: _green,
                                  ),
                                ),
                                Text(
                                  project.companyName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: _green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    const Text(
                      'Students are looking for:\n',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: MarkdownBody(
                              data: project.description,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/clock.png',
                          height: 50.0,
                          width: 50.0,
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.project_scope,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              getProjectScopeFormart(project.projectScopeFlag),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/group.png',
                          height: 50.0,
                          width: 50.0,
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.student_required,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .student_needed_project(
                                      project.numberOfStudents),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.isOffer
                        ? Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _green,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Cancel',
                                      style: TextStyle(fontSize: 16)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    update();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: _green,
                                      foregroundColor: Colors.white),
                                  child: const Text('Accept',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                          )
                        : SizedBox()
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
