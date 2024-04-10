import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/saved_projects_screen.dart';
import 'package:studenthub/components/company_project/card_project_list.dart';
import 'package:studenthub/components/company_project/pop_up_filter_project.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your ProjectListTab

const Color _green = Color(0xFF12B28C);
var blackColor = Colors.black54;

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ProjectPopupFilter.show(context);
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
                  ProjectListTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
