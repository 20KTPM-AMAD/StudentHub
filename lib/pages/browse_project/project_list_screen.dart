import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/project_detail_screen.dart';
import 'package:studenthub/pages/browse_project/saved_projects_screen.dart';
import 'package:studenthub/components/company_project/pop_up_filter_project.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xFF12B28C);
var blackColor = Colors.black54;

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectListScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController studentsController = TextEditingController();
  TextEditingController proposalsController = TextEditingController();
  String? selectedIndex;
  List<Project> projects = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllProjects();
  }

  Future<void> getAllProjects() async {
    setState(() {
      isLoading = true;
    });

    String url = 'http://34.16.137.128/api/project';

    Map<String, String> queryParams = {};

    if (searchController.text.isNotEmpty) {
      queryParams['title'] = searchController.text;
    }

    if (studentsController.text.isNotEmpty) {
      queryParams['numberOfStudents'] = studentsController.text;
    }

    if (proposalsController.text.isNotEmpty) {
      queryParams['proposalsLessThan'] = proposalsController.text;
    }

    if (selectedIndex != null) {
      print(selectedIndex);
      queryParams['projectScopeFlag'] = selectedIndex.toString();
    }

    if (queryParams.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParams).query}';
    }

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        final response = await http.get(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          if (jsonResponse['result'] is List) {
            setState(() {
              projects = jsonResponse['result'].map<Project>((data) => Project.fromJson(data)).toList();
            });
          } else {
            print('Response is not a list of projects');
          }
        } else {
          print('Failed to get list project: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to fetch projects'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (error) {
      print('Failed to get list project: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _getTimeElapsed(DateTime createdAt) {
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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 270,
                        child: TextField(
                          controller: searchController,
                          showCursor: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            hintText: AppLocalizations.of(context)!.search,
                            prefixIcon: Icon(Icons.search, color: blackColor.withOpacity(.6)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: _green.withOpacity(.1),
                          ),
                          onSubmitted: (value) {
                            print('searchText: $value');
                            getAllProjects();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic?>? filterValues = await ProjectPopupFilter.show(context);
                          if (filterValues != null) {
                            studentsController.text = filterValues['students'] ?? '';
                            proposalsController.text = filterValues['proposals'] ?? '';
                            selectedIndex = filterValues['range'] as String?;
                            getAllProjects();
                          }
                        },
                        icon: const Icon(Icons.filter_alt_outlined, size: 30),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SavedProjectsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildProjectList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    return RefreshIndicator(
      onRefresh: getAllProjects,
      child: ListView.separated(
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
                      Expanded(
                        child: Text(
                          project.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: _green,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      IconButton(
                        onPressed: () {
                          // Handle favorite button press
                        },
                        icon: Icon(
                          project.isFavorite == true ? Icons.favorite : Icons.favorite_border_outlined,
                          size: 30,
                          color: project.isFavorite == true ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _getTimeElapsed(project.createdAt),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.time_needed_project(project.projectScopeFlag)}, ${AppLocalizations.of(context)!.student_needed_project(project.numberOfStudents)}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
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
                  const SizedBox(height: 10),
                  Text(
                    '${AppLocalizations.of(context)!.proposals}: ${project.countProposals}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailScreen(), // Pass project detail to ProjectDetailScreen
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
