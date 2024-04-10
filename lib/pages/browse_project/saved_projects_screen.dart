import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/company_project/card_saved_project.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/project_detail_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class SavedProjectsScreen extends StatefulWidget {
  const SavedProjectsScreen({Key? key}) : super(key: key);

  @override
  SavedProjectsState createState() => SavedProjectsState();
}

class SavedProjectsState extends State<SavedProjectsScreen> {
  @override
  void initState() {
    super.initState();
    getAllFavoriteProjects();
  }

  List<Project> projects = [];
  bool isLoading = false;

  Future<void> getAllFavoriteProjects() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final student =
          Provider.of<AuthProvider>(context, listen: false).loginUser!.student;
      if (token != null && student != null) {
        final response = await http.get(
          Uri.parse('http://34.16.137.128/api/favoriteProject/${student.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['result'] is List) {
            setState(() {
              projects = jsonResponse['result']
                  .map<Project>((data) => Project.fromJson(data['project']))
                  .toList();
            });
          } else {
            print('Response is not a list of projects');
          }
        } else {
          log('Failed to get list project: ${response.body}');
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

  Future<bool> _onFavoriteButtonPressed(int projectId, bool disableFlag) async {
    final student =
        Provider.of<AuthProvider>(context, listen: false).loginUser!.student;
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    if (student != null && token != null) {
      final response = await http.patch(
        Uri.parse('http://34.16.137.128/api/favoriteProject/${student.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, int>{
          'projectId': projectId,
          'disableFlag': disableFlag ? 1 : 0,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to favorite project: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to favorite project'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }
    return false;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved projects'),
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildProjectList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.view_list), label: 'Projects'),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
        ],
        backgroundColor: _green,
      ),
    );
  }

  Widget _buildProjectList() {
    return RefreshIndicator(
      onRefresh: getAllFavoriteProjects,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
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
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle favorite button press
                          _onFavoriteButtonPressed(project.id, true)
                              .then((value) {
                            if (value) {
                              setState(() {
                                projects.removeAt(index);
                              });
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red,
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
                    builder: (context) =>
                        ProjectDetailScreen(), // Pass project detail to ProjectDetailScreen
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
