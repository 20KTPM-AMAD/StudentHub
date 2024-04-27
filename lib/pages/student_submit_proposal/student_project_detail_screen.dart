import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

class StudentProjectDetailScreen extends StatefulWidget {
  const StudentProjectDetailScreen({Key? key, required this.id})
      : super(key: key);

  final int id;
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
                    children: [
                      Image.asset('assets/images/project_detail.jpg'),
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
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: _green,
                        ),
                      ),
                      const Divider(),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'Students are looking for:\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                            'assets/images/clock.jpeg',
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
                                getProjectScopeFormart(
                                    project.projectScopeFlag),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
