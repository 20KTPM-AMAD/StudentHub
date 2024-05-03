import 'package:flutter/material.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/post_project_step_4.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xff296e48);

class PostProjectStep3Screen extends StatefulWidget {
  PostProjectStep3Screen(
      {Key? key,
      required this.title,
      required this.projectScopeFlag,
      required this.numberOfStudents, this.project})
      : super(key: key);

  final String title;
  final String projectScopeFlag;
  final String numberOfStudents;

  final Project? project;

  @override
  PostProjectStep3State createState() => PostProjectStep3State();
}

class PostProjectStep3State extends State<PostProjectStep3Screen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.project != null) {
      descriptionController.text = widget.project!.description;
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    '3/4',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.provide_description,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Row(
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
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '\u2022 Clear expectation about your project and deliverables',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '\u2022 The skills required for your project',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '\u2022 Details about your project',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.describe_your_project,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descriptionController,
                    maxLines: 6, //or null
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: const OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _green),
                      ),
                      hintText: AppLocalizations.of(context)!.hint_description,
                      hintStyle: const TextStyle(color: _green),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostProjectStep4Screen(
                                title: widget.title,
                                projectScopeFlag: widget.projectScopeFlag,
                                numberOfStudents: widget.numberOfStudents,
                                description: descriptionController.text,
                                project: widget.project)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(AppLocalizations.of(context)!.review_your_post,
                        style: const TextStyle(fontSize: 18)),
                  ),
                ],
              )
            ])));
  }
}
