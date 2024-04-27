import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/components/student_project/student_tab_all_projects.dart';
import 'package:studenthub/components/student_project/student_tab_projects.dart';
import 'package:studenthub/contanst/contanst.dart';

const Color _green = Color(0xff296e48);

class AllProjectsScreen extends StatefulWidget {
  const AllProjectsScreen({Key? key}) : super(key: key);

  @override
  AllProjectsScreenState createState() => AllProjectsScreenState();
}

class AllProjectsScreenState extends State<AllProjectsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.your_project,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(
                        text: AppLocalizations.of(context)!.all_projects,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.working,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.archived,
                      ),
                    ]),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          200, // Giảm đi kích thước của AppBar và khoảng cách dưới cùng
                      child: TabBarView(
                        children: [
                          const StudentAllProjectsTab(),
                          StudentProjectsTab(statusFlag: StatusFlag.Hired.index.toString(), typeFlag: '0,1'),
                          StudentProjectsTab(statusFlag: StatusFlag.Hired.index.toString(), typeFlag: '2'),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
