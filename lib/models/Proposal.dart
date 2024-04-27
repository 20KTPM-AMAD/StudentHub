import 'package:studenthub/contanst/contanst.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studenthub/models/Project.dart';
import 'Student.dart';

class Proposal {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? deletedAt;
  final int projectId;
  final int studentId;
  final String coverLetter;
  final int statusFlag;
  final int disableFlag;

  late Student? student;
  late Project? project;
  late String? studentname;

  Proposal({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.studentId,
    required this.coverLetter,
    required this.statusFlag,
    required this.disableFlag,
    this.student,
    this.project,
    this.studentname,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) {
    final studentJson = json['student'];
    final studentName = studentJson != null && studentJson['user'] != null
        ? studentJson['user']['fullname']
        : null;

    return Proposal(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'],
      projectId: json['projectId'],
      studentId: json['studentId'],
      coverLetter: json['coverLetter'],
      statusFlag: json['statusFlag'],
      disableFlag: json['disableFlag'],
      student:
          json['student'] != null ? Student.fromJson(json['student']) : null,
      project:
          json['project'] != null ? Project.fromJson(json['project']) : null,
      studentname: studentName,
    );
  }
}

Future<List<Proposal>> getProposalByStudentId(
    int studentId, String? statusFlag, String? typeFlag, String token) async {
  studentHubUrl = '$studentHubUrl/proposal/project/$studentId';

  var queryParameters;

  if (statusFlag != null) {
    queryParameters = {'statusFlag': statusFlag};
  }

  if (typeFlag != null) {
    queryParameters = {...queryParameters, 'typeFlag': typeFlag};
  }

  final uri = Uri.https('api.studenthub.dev', '/api/proposal/project/$studentId', queryParameters);

  final response = await http.get(uri, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    final List<dynamic> proposalList = jsonResponse['result'];

    List<Proposal> proposals = [];
    for (var proposalJson in proposalList) {
      proposals.add(Proposal.fromJson(proposalJson));
    }

    return proposals;
  } else {
    throw Exception('Failed to load proposals');
  }

  return [];
}
