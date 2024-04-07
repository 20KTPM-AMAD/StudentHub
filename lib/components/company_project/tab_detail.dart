import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/models/Project.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xFF12B28C);

class DetailTab extends StatefulWidget {
  const DetailTab({Key? key, required this.projectId}) : super(key: key);

  final int projectId;

  @override
  DetailTabState createState() => DetailTabState();
}

class DetailTabState extends State<DetailTab> {
  Project? _project;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getProject();
  }

  String getProjectScopeText(String flag) {
    switch (flag) {
      case '0':
        return AppLocalizations.of(context)!.less_than_one_month;
      case '1':
        return AppLocalizations.of(context)!.one_to_three_months;
      case '2':
        return AppLocalizations.of(context)!.three_to_six_months;
      case '3':
        return AppLocalizations.of(context)!.more_than_six_months;
      default:
        return '';
    }
  }

  Future<void> _getProject() async {
    setState(() {
      _isLoading = true;
    });

    try {
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
          if (jsonResponse['result']['project'] != null) {
            setState(() {
              _project = Project.fromJson(jsonResponse['result']['project']);
            });
          } else {
            print('Response is not a list of projects');
          }
        } else {
          print('Failed to get project: ${response.body}');
        }
      }
    } catch (error) {
      print('Failed to get list project: $error');
      // Handle error cases here, show error message to user
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _buildProjectDetails();
  }

  Widget _buildProjectDetails() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Students are looking for:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                                height: 30), // Khoảng cách giữa các dòng
                          ),
                          WidgetSpan(
                            child: MarkdownBody(
                              data: _project!.description,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 3),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.alarm_outlined,
                          size: 40,
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.project_scope,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                                getProjectScopeText(_project!.projectScopeFlag.toString()),
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
                        const Icon(
                          Icons.group_outlined,
                          size: 40,
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.student_required,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              '${_project!.numberOfStudents} students',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: _green, foregroundColor: Colors.black),
              child: Text(AppLocalizations.of(context)!.post_job,
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
