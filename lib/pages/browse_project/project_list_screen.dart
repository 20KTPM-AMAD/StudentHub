import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/project_detail_screen.dart';
import 'package:studenthub/pages/browse_project/saved_projects_screen.dart';
import 'package:studenthub/components/company_project/pop_up_filter_project.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectListScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController studentsController = TextEditingController();
  TextEditingController proposalsController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String selectedIndex = '';
  List<Project> projects = [];
  bool isLoading = false;
  bool isAddingMore = false;
  int currentPage = 1;
  int pageSize = 10;
  bool checkCompany = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    checkRole();
    getProjects();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void checkRole() {
    checkCompany = Provider.of<AuthProvider>(context, listen: false).role ==
        UserRole.Company;
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreProjects();
    }
  }

  Future<void> getProjects({bool loadMore = false}) async {
    if (isLoading || (loadMore && isAddingMore)) return;
    setState(() {
      if (!loadMore) {
        isLoading = true;
      } else {
        isAddingMore = true;
      }
    });

    String url = 'https://api.studenthub.dev/api/project';

    Map<String, String> queryParams = {
      'page': loadMore ? (currentPage + 1).toString() : currentPage.toString(),
      'perPage': pageSize.toString(),
    };

    if (searchController.text.isNotEmpty) {
      queryParams['title'] = searchController.text;
      log(searchController.text);
    }

    if (studentsController.text.isNotEmpty) {
      queryParams['numberOfStudents'] = studentsController.text;
    }

    if (proposalsController.text.isNotEmpty) {
      queryParams['proposalsLessThan'] = proposalsController.text;
    }

    if (selectedIndex.isNotEmpty) {
      queryParams['projectScopeFlag'] = selectedIndex.toString();
    }

    if (queryParams.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParams).query}';
    }

    log(url);

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
          if (jsonResponse['result'] is List) {
            if (!loadMore) {
              setState(() {
                currentPage = 1;
                projects.clear(); // Clear projects list if not loading more
              });
            }
            setState(() {
              final List<Project> newProjects = jsonResponse['result']
                  .map<Project>((data) => Project.fromJson(data))
                  .toList();
              setState(() {
                projects.addAll(newProjects);
                currentPage++;
                isLoading = false;
              });
            });
          } else {
            print('Response is not a list of projects');
          }
        } else {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['errorDetails'].contains("No projects found")) {
            setState(() {
              currentPage = 1;
              projects.clear(); // Clear projects list if no projects found
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No projects found'),
                backgroundColor: Colors.red,
              ),
            );
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

  Future<void> loadMoreProjects() async {
    if (isLoading || isAddingMore) return;
    setState(() {
      isAddingMore = true;
    });

    String url = 'https://api.studenthub.dev/api/project';

    Map<String, String> queryParams = {
      'page': currentPage.toString(),
      'perPage': pageSize.toString(),
    };

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

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['result'] is List) {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              final List<Project> newProjects = jsonResponse['result']
                  .map<Project>((data) => Project.fromJson(data))
                  .toList();
              projects.addAll(newProjects);
              currentPage++;
              isAddingMore = false;
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
      setState(() {
        isAddingMore = false;
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
        log('Failed to favorite project: ${response.body}');
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

  void sortProjectsAlphabetically() {
    setState(() {
      projects.sort((a, b) => a.title.compareTo(b.title));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: searchController,
                          showCursor: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            hintText: AppLocalizations.of(context)!.search,
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                          onSubmitted: (value) {
                            print('searchText: $value');
                            setState(() {
                              projects.clear();
                              currentPage = 1;
                            });
                            getProjects();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Map<String, dynamic?>? filterValues =
                              await ProjectPopupFilter.show(context);
                          if (filterValues != null) {
                            studentsController.text =
                                filterValues['students'] ?? '';
                            proposalsController.text =
                                filterValues['proposals'] ?? '';
                            selectedIndex = (filterValues['range'] as String?)!;
                            setState(() {
                              projects.clear();
                              currentPage = 1;
                            });
                            getProjects();
                          }
                        },
                        icon: const Icon(Icons.filter_alt_outlined, size: 30),
                      ),
                      IconButton(
                        onPressed: () {
                          sortProjectsAlphabetically();
                        },
                        icon:
                            const Icon(Icons.sort_by_alpha_outlined, size: 30),
                      ),
                      if (checkCompany == false)
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SavedProjectsScreen(),
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
                      : buildProjectList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProjectList() {
    return RefreshIndicator(
      onRefresh: getProjects,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
        itemCount: projects.length + 1,
        itemBuilder: (context, index) {
          if (projects.isEmpty) {
            return const Center(
              child: Text('There are currently no projects'),
            );
          } else if (index == projects.length) {
            return isAddingMore
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox();
          } else {
            final project = projects[index];
            return Card(
              margin: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/project.png',
                          color: Colors.grey,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.company}: ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _green,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.27),
                                    child: Text(
                                      project.companyName!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _green,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _getTimeElapsed(project.createdAt),
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (checkCompany == false)
                          IconButton(
                            onPressed: () {
                              // Handle favorite button press
                              _onFavoriteButtonPressed(
                                      project.id, project.isFavorite!)
                                  .then((value) {
                                if (value) {
                                  setState(() {
                                    project.isFavorite = !project.isFavorite!;
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              project.isFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 30,
                              color: project.isFavorite == true
                                  ? Colors.red
                                  : null,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.proposals}: ${project.countProposals}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      '${getProjectScopeFormart(project.projectScopeFlag)}\n${AppLocalizations.of(context)!.student_needed_project(project.numberOfStudents)}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDetailScreen(
                          name: project.title,
                          description: project.description,
                          compnayName: project.companyName!,
                          projectScope: project.projectScopeFlag,
                          numberOfStudents: project.numberOfStudents),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
