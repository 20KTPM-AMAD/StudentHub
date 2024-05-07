import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/student_project/student_project_detail_card.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

class StudentAllProjectsTab extends StatefulWidget {
  const StudentAllProjectsTab({Key? key}) : super(key: key);

  @override
  StudentAllProjectsTabState createState() => StudentAllProjectsTabState();
}

class StudentAllProjectsTabState extends State<StudentAllProjectsTab> {
  late List<Proposal> proposalsActive = [];

  late List<Proposal> proposalsSubmitted = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final loginUser =
        Provider.of<AuthProvider>(context, listen: false).loginUser;
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    try {
      //active
      final List<dynamic> proposalsActiveList = await getProposalByStudentId(
          loginUser!.student!.id,
          '1,2',
          null,
          token!);

      setState(() {
        proposalsActive = proposalsActiveList
            .map((dynamic item) => Proposal.fromJson(item))
            .toList();
      });

      // submitted
      final List<dynamic> proposalsSubmittedlist = await getProposalByStudentId(
          loginUser.student!.id,
          StatusFlag.Waitting.index.toString(),
          null,
          token);

      setState(() {
        proposalsSubmitted = proposalsSubmittedlist
            .map((dynamic item) => Proposal.fromJson(item))
            .toList();
      });

    } catch (error) {
      // Handle error here
      print('Error fetching proposals: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildProject();
  }

  Widget buildProject() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: _green, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .active_proposal(proposalsActive.length.toString()),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: proposalsActive.length,
                    itemBuilder: (context, index) {
                      final Proposal proposal = proposalsActive[index];
                      return StudentProjectDetailCard(
                        proposal: proposal, isActive: true
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: _green, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          AppLocalizations.of(context)!.submitted_proposal(
                              proposalsSubmitted.length.toString()),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: proposalsSubmitted.length,
                    itemBuilder: (context, index) {
                      final Proposal proposal = proposalsSubmitted[index];
                      return StudentProjectDetailCard(
                        proposal: proposal,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
