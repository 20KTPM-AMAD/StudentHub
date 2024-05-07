import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studenthub/components/company_project/pop_up_menu_project.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/company_reviews_proposal/send_hire_offer_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xFF12B28C);

class AllProjectsWorkingTab extends StatefulWidget {
  const AllProjectsWorkingTab({Key? key}) : super(key: key);

  @override
  AllProjectsWorkingTabState createState() => AllProjectsWorkingTabState();
}

class AllProjectsWorkingTabState extends State<AllProjectsWorkingTab> {
  List<Project> projects = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  Future<void> getProjects() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final companyId =
          Provider.of<AuthProvider>(context, listen: false).loginUser!.company!.id;
      if (token != null) {
        final response = await http.get(
          Uri.parse('http://34.16.137.128/api/project/company/$companyId?typeFlag=1'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          if (jsonResponse['result'] is List) { // Check if jsonResponse is a list
            setState(() {
              projects = jsonResponse['result'].map<Project>((data) => Project.fromJson(data)).toList();
            });
          } else {
            print('Response is not a list of projects');
          }
        } else {
          print('Failed to get list project: ${response.body}');
          // Handle error cases here, show error message to user
        }
      }
    } catch (error) {
      print('Failed to get list project: $error');
      // Handle error cases here, show error message to user
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getTimeElapsed(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return AppLocalizations.of(context)!.days_ago(difference.inDays);
    } else if (difference.inHours > 0) {
      return AppLocalizations.of(context)!.hours_ago(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return AppLocalizations.of(context)!.minutes_ago(difference.inMinutes);
    } else {
      return AppLocalizations.of(context)!.just_now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildProjectList();
  }

  Widget buildProjectList() {
    return RefreshIndicator(
      onRefresh: getProjects,
      child: projects.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.no_projects, style: const TextStyle(fontSize: 18.0),),)
          : ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Card(
            margin: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/project.png', fit: BoxFit.cover, width: 80, height: 80,),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: _green,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              getTimeElapsed(project.createdAt),
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      IconButton(
                        onPressed: () {
                          AllProjectsPopupMenu.show(context, project);
                        },
                        icon: const Icon(Icons.pending_outlined, size: 30,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Students are looking for:\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProjectDetailColumn('${project.countProposals}', AppLocalizations.of(context)!.proposals),
                      const SizedBox(width: 20),
                      buildProjectDetailColumn('${project.countMessages}', AppLocalizations.of(context)!.messages),
                      const SizedBox(width: 20),
                      buildProjectDetailColumn('${project.countHired}', AppLocalizations.of(context)!.hired),
                    ],
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SendHireOfferScreen(projectId: project.id)),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildProjectDetailColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}