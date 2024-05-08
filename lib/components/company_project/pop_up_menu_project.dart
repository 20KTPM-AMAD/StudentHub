import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/post_project_step_1_screen.dart';
import 'package:studenthub/pages/browse_project/project_detail_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/send_hire_offer_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';

class AllProjectsPopupMenu {
  static void show(BuildContext context, Project project) {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 420,
                child: ListView(
                  physics: const ScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_proposals,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SendHireOfferScreen(projectId: project.id)),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_messages,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendHireOfferScreen(
                              projectId: project.id,
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_hired,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendHireOfferScreen(
                              projectId: project.id,
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_job_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                    numberOfStudents: project.numberOfStudents,
                                  )
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.edit_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostProjectStep1Screen(project: project)),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.archive_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _confirmArchivePosting(context, token!, project.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.remove_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _confirmRemovePosting(context, token!, project.id);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.start_working_this_job,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _confirmWorkingPosting(context, token!, project.id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _confirmRemovePosting(
      BuildContext context, String? token, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirm_remove_posting),
          content: Text(AppLocalizations.of(context)!.sure_remove_posting),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                _handleRemovePosting(token!, id, context);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        );
      },
    );
  }

  static void _confirmArchivePosting(
      BuildContext context, String? token, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirm_archive_posting),
          content: Text(
            AppLocalizations.of(context)!.sure_archive_posting,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                _handleArchivePosting(token!, id, context);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        );
      },
    );
  }

  static void _handleRemovePosting(
      String token, int id, BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse('http://34.16.137.128/api/project/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.remove_posting_successfully),
          ),
        );
      } else {
        print('Failed to remove posting: ${response.body}');
      }
    } catch (error) {
      print('Failed to remove posting: $error');
    }
  }

  static void _handleArchivePosting(
      String token, int id, BuildContext context) async {
    try {
      final response = await http.patch(
        Uri.parse('http://34.16.137.128/api/project/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, dynamic>{
          'typeFlag': '2',
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.archive_posting_successfully),
          ),
        );
      } else {
        print('Failed to archive posting: ${response.body}');
      }
    } catch (error) {
      print('Failed to archive posting: $error');
    }
  }

  static void _confirmWorkingPosting(
      BuildContext context, String? token, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirm_working_posting),
          content: Text(
            AppLocalizations.of(context)!.sure_working_posting,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                _handleWorkingPosting(token!, id, context);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        );
      },
    );
  }

  static void _handleWorkingPosting(
      String token, int id, BuildContext context) async {
    try {
      final response = await http.patch(
        Uri.parse('http://34.16.137.128/api/project/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: <String, dynamic>{
          'typeFlag': '1',
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.working_posting_successfully),
          ),
        );
      } else {
        print('Failed to archive posting: ${response.body}');
      }
    } catch (error) {
      print('Failed to archive posting: $error');
    }
  }
}
