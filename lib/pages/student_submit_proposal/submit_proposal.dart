import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/models/User.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({Key? key, required this.projectId})
      : super(key: key);

  final int projectId;

  @override
  SubmitProposalScreenState createState() => SubmitProposalScreenState();
}

class SubmitProposalScreenState extends State<SubmitProposalScreen> {
  TextEditingController coverLetterController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.cover_letter,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.why_fit_project,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: coverLetterController,
                    maxLines: 8, //or null
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: _green, width: 2),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String? token =
                          Provider.of<AuthProvider>(context, listen: false)
                              .token;

                      final User? loginUser =
                          Provider.of<AuthProvider>(context, listen: false)
                              .loginUser;

                      await createProposal(
                          widget.projectId,
                          loginUser!.student!.id,
                          coverLetterController.text,
                          token);

                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _green, foregroundColor: Colors.white),
                    child: Text(AppLocalizations.of(context)!.submit_proposal,
                        style: const TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
