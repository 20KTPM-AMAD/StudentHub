import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:studenthub/pages/student_submit_proposal/submit_proposal.dart';

const Color _green = Color(0xff296e48);

class ProjectDetailScreen extends StatefulWidget {
  final int id;
  final String name, description, compnayName;
  final int projectScope, numberOfStudents;
  const ProjectDetailScreen({Key? key, required this.name, required this.description, required this.compnayName, required this.projectScope, required this.numberOfStudents, required this.id}) : super(key: key);

  @override
  ProjectDetailState createState() => ProjectDetailState();
}

class ProjectDetailState extends State<ProjectDetailScreen>{
  @override
  void initState() {
    super.initState();
  }

  String getProjectScopeFormart(int projectScope) {
    if (projectScope == 0) {
      return AppLocalizations.of(context)!.time_needed_project('Less than one month');
    } else if (projectScope == 1) {
      return AppLocalizations.of(context)!.time_needed_project('1-3');
    } else if (projectScope == 2) {
      return AppLocalizations.of(context)!.time_needed_project('3-6');
    } else {
      return AppLocalizations.of(context)!.time_needed_project('More than 6 months');
    }
  }

  @override
  Widget build(BuildContext context){
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
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/project_detail.png', fit: BoxFit.cover, width: 100, height: 100,),
                        const SizedBox(width: 10,),
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
                            const SizedBox(height: 10,),
                            Container(
                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                                child: Text(
                                widget.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _green,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
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
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
                                  child: Text(
                                    widget.compnayName,
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
                              data: widget.description,
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
                        Image.asset('assets/images/clock.png', height: 50.0, width: 50.0,),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.project_scope,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            Text(
                                getProjectScopeFormart(widget.projectScope),
                                style: const TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/group.png', height: 50.0, width: 50.0,),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.student_required,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.student_needed_project(widget.numberOfStudents),
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              SubmitProposalScreen(projectId: widget.id)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Apply Now', style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _green,
                          foregroundColor: Colors.white
                      ),
                      child: const Text('Saved', style: TextStyle(fontSize: 16)),
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