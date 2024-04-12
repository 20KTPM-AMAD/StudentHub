import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/company_project/tab_all_projects.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/post_project_step_1_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<DashboardScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.your_project,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const PostProjectStep1Screen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              foregroundColor: Colors.black
                          ),
                          child: Text(AppLocalizations.of(context)!.post_a_project, style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                                tabs: [
                                  Tab(text: AppLocalizations.of(context)!.all_projects,),
                                  Tab(text: AppLocalizations.of(context)!.working,),
                                  Tab(text: AppLocalizations.of(context)!.archived,),
                                ]
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - kToolbarHeight - 200, // Giảm đi kích thước của AppBar và khoảng cách dưới cùng
                              child: const TabBarView(
                                children: [
                                  AllProjectsTab(),
                                  Center(
                                    child: Text('Working Projects Content'),
                                  ),
                                  Center(
                                    child: Text('Archived Projects Content'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
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
