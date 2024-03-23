import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:studenthub/pages/browse_project/saved_projects_screen.dart';
import 'package:studenthub/components/company_project/card_project_list.dart';
import 'package:studenthub/components/company_project/pop_up_filter_project.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectListScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> suggestions = [
    'Flutter',
    'Dart',
    'Mobile',
    'App',
    'Development',
  ];
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 260,
                      child: AutoCompleteTextField<String>(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          hintText: AppLocalizations.of(context)!.search,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        itemSubmitted: (String item) {
                          // Xử lý khi người dùng chọn gợi ý
                        },
                        key: key,
                        suggestions: suggestions,
                        itemBuilder: (context, String suggestion) => ListTile(
                          title: Text(suggestion),
                        ),
                        itemSorter: (String a, String b) => a.compareTo(b),
                        itemFilter: (String suggestion, String query) {
                          return suggestion
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
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
                              builder: (context) =>
                                  const SavedProjectsScreen()),
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
                const ProjectListTab(),
              ],
            ),
          ),
        ],
      ),
    ));
    //   ),
    //   bottomNavigationBar: NavigationBar(
    //     height: 60,
    //     destinations: const [
    //       NavigationDestination(icon: Icon(Icons.view_list), label: 'Projects'),
    //       NavigationDestination(icon: Icon(Icons.home), label: 'Dashboard',),
    //       NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
    //       NavigationDestination(icon: Icon(Icons.notifications), label: 'Alerts',),
    //     ],
    //     backgroundColor: _green,
    //   ),
    // );
  }
}
