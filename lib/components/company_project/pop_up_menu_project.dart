import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studenthub/utils/auth_provider.dart';

class AllProjectsPopupMenu {
  static void show(BuildContext context, int id) {
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
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_messages,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_hired,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.view_job_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.edit_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.remove_posting,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _confirmRemovePosting(context, token!, id);
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.start_working_this_job,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
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
          title: Text('Confirm remove posting'),
          content: Text('Are you sure you want to remove this posting?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _handleRemovePosting(token!, id, context);
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
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
            content: Text('Remove posting successfully'),
          ),
        );
      } else {
        print('Failed to remove posting: ${response.body}');
      }
    } catch (error) {
      print('Failed to remove posting: $error');
    }
  }
}
