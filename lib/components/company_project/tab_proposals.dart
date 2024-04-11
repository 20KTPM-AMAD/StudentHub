import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Proposal.dart';
import 'package:studenthub/pages/chat/message_detail_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/proposal_profile_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'notification_send_hire_offer.dart';
import 'package:http/http.dart' as http;

var blackColor = Colors.black54;
var primaryColor = const Color(0xff296e48);

class ProposalsTab extends StatefulWidget {
  const ProposalsTab({Key? key, required int this.projectId}) : super(key: key);
  final int projectId;
  @override
  ProposalsTabState createState() => ProposalsTabState();
}

class ProposalsTabState extends State<ProposalsTab> {
  List<Proposal> proposals = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllProposals();
  }

  Future<void> getAllProposals() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      print('projectId: ${widget.projectId}');
      if (token != null) {
        final response = await http.get(
          Uri.parse('http://34.16.137.128/api/proposal/getByProjectId/${widget.projectId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['result']['items'] != null && (jsonResponse['result']['items'] as List).isNotEmpty) {
            setState(() {
              proposals = (jsonResponse['result']['items'] as List).map((item) => Proposal.fromJson(item)).toList();
            });
          } else {
            proposals = [];
          }
        } else {
          print('Failed to get list project: ${response.body}');
        }
      }
    } catch (error) {
      print('Failed to get list project: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getTimeElapsed(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return AppLocalizations.of(context)!.days_ago(difference.inDays);
    } else if (difference.inHours > 0) {
      return AppLocalizations.of(context)!.hours_ago(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return AppLocalizations.of(context)!.minutes_ago(difference.inMinutes);
    } else {
      return AppLocalizations.of(context)!.just_now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildProposalList();
  }

  Widget buildProposalList() {
    return RefreshIndicator(
      onRefresh: getAllProposals,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        itemCount: proposals.isEmpty ? 1 : proposals.length,
        itemBuilder: (context, index) {
          if (proposals.isEmpty) {
            return const Center(
              child: Text('Hiện tại chưa có proposal nào'),
            );
          }

          final proposal = proposals[index];
          final student = proposal.student;
          final techStack = student.techStack;

          return Card(
            margin: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/student.png', fit: BoxFit.cover, width: 100, height: 100,),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.fullname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis, // Hiển thị dấu ... khi văn bản tràn ra ngoài
                            ),
                            Text(
                              getTimeElapsed(proposal.createdAt),
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        techStack.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    proposal.coverLetter,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessageDetailScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.black,
                          fixedSize: const Size(130, 40),
                        ),
                        child: Text(AppLocalizations.of(context)!.message, style: const TextStyle(fontSize: 18, color: Colors.white70)),
                      ),
                      ElevatedButton(
                        onPressed:() {
                          SendHireOfferDialog.showMyDialog(context, proposal.id, getAllProposals);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.black,
                          fixedSize: const Size(130, 40),
                        ),
                        child: Text(
                          proposal.statusFlag == 1
                              ? AppLocalizations.of(context)!.send_hired_offer
                              : 'Sent hired offer',
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProposalDetailScreen(fullname: student.fullname, coverLetter: proposal.coverLetter, techStackName: techStack.name)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
