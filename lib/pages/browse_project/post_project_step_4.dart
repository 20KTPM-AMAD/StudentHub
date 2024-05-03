import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/main_screen.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

enum Range {
  LessThanOneMonth,
  OneToThreeMonths,
  ThreeToSixMonths,
  MoreThanSixMonths
}

class PostProjectStep4Screen extends StatefulWidget {
  const PostProjectStep4Screen(
      {Key? key,
      required this.title,
      required this.projectScopeFlag,
      required this.numberOfStudents,
      required this.description, this.project})
      : super(key: key);

  final String title;
  final String projectScopeFlag;
  final String numberOfStudents;
  final String description;

  final Project? project;

  @override
  PostProjectStep4State createState() => PostProjectStep4State();
}

class PostProjectStep4State extends State<PostProjectStep4Screen> {
  @override
  void initState() {
    super.initState();
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

  Future<void> _createProject() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    final loginUser = Provider.of<AuthProvider>(context, listen: false).loginUser;

    final response = await http.post(
      Uri.parse('http://34.16.137.128/api/project'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'companyId': loginUser!.company!.id,
        'projectScopeFlag': int.parse(widget.projectScopeFlag),
        'title': widget.title,
        'numberOfStudents': int.parse(widget.numberOfStudents),
        'description': widget.description,
        'typeFlag': 0
      }),
    );

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      if (jsonResponse['result'] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    }
  }

  Future<void> _updateProject() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    final loginUser = Provider.of<AuthProvider>(context, listen: false).loginUser;

    final response = await http.patch(
      Uri.parse('http://34.16.137.128/api/project/${widget.project!.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'projectScopeFlag': int.parse(widget.projectScopeFlag),
        'title': widget.title,
        'numberOfStudents': int.parse(widget.numberOfStudents),
        'description': widget.description,
      }),
    );

    final jsonResponse = json.decode(response.body);

    print(response.statusCode);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['result'] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
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
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      '4/4',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.project_detail,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: _green,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Student are looking for:',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: MarkdownBody(
                          data: widget.description,
                          styleSheet: MarkdownStyleSheet(
                            textScaleFactor: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.project_scope,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '\u2022${getProjectScopeText(widget.projectScopeFlag)}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.person_2,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.student_required,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '\u2022 ${widget.numberOfStudents} students',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    widget.project != null ?
                    ElevatedButton(
                      onPressed: () {
                        print('update');
                        _updateProject();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(AppLocalizations.of(context)!.edit_job,
                          style: const TextStyle(fontSize: 18)),
                    ) :
                    ElevatedButton(
                      onPressed: () {
                        print('create');
                        _createProject();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(AppLocalizations.of(context)!.post_job,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                )
              ],
            )));
  }
}
