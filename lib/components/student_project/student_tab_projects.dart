import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/student_project/student_project_detail_card.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

class StudentProjectsTab extends StatefulWidget {
   const StudentProjectsTab({Key? key, required this.statusFlag, required this.typeFlag}) : super(key: key);

  final String statusFlag;
  final String typeFlag;

  @override
  StudentProjectsTabState createState() => StudentProjectsTabState();
}

class StudentProjectsTabState extends State<StudentProjectsTab> {
  late List<Proposal> proposals = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final loginUser =
        Provider.of<AuthProvider>(context, listen: false).loginUser;
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    try {
      //active
      final List<dynamic> proposalsActiveList = await getProposalByStudentId(
          loginUser!.student!.id, widget.statusFlag, widget.typeFlag, token!);
      setState(() {
        proposals = proposalsActiveList.cast<Proposal>();
      });
    } catch (error) {
      // Handle error here
      print('Error fetching proposals: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (proposals.isEmpty) ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
              itemCount: proposals.length,
              itemBuilder: (context, index) {
                final Proposal proposal = proposals[index];
                return StudentProjectDetailCard(
                  proposal: proposal,
                );
              },
            ),
          ] else ...[
            // Placeholder widget when proposals are not loaded yet
            const Text('You do not having project on working'),
          ],
        ],
      ),
    );
  }
}
