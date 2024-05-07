import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/student_project/student_project_detail_card.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/utils/auth_provider.dart';

const Color _green = Color(0xff296e48);

class StudentProjectsTab extends StatefulWidget {
  const StudentProjectsTab(
      {Key? key, required this.statusFlag, required this.typeFlag})
      : super(key: key);

  final String statusFlag;
  final String typeFlag;

  @override
  StudentProjectsTabState createState() => StudentProjectsTabState();
}

class StudentProjectsTabState extends State<StudentProjectsTab> {
  late List<Proposal> proposals = [];

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
      List<dynamic> proposalsActiveList = await getProposalByStudentId(
          loginUser!.student!.id, widget.statusFlag, widget.typeFlag, token!);
      setState(() {
        proposals = proposalsActiveList
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
        children: [
          Visibility(
            visible: proposals.isNotEmpty,
            child: ListView.separated(
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
          ),
          Visibility(
            visible: proposals.isEmpty,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'You do not have any projects yet.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
