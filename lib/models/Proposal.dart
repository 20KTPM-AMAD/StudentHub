import 'dart:ffi';

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

Future<List<dynamic>> getProposalByStudentId(
    int studentId, String? statusFlag, String? typeFlag, String token) async {
  studentHubUrl = '$studentHubUrl/proposal/project/$studentId';

  Map<String, dynamic>? queryParameters;
  if (statusFlag != null) {
    queryParameters = {'statusFlag': statusFlag};
  }

  if (typeFlag != null) {
    queryParameters = queryParameters ?? {};
    queryParameters['typeFlag'] = typeFlag;
  }

  final uri = Uri.https('api.studenthub.dev',
      '/api/proposal/project/$studentId', queryParameters);

  final response = await http.get(uri, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    final List<dynamic> proposalList = jsonResponse['result'];

    return proposalList;
  } else {
    throw Exception('Failed to load proposals');
  }
}

Future<void> updateProposal(int id, int statusFlag, String? token) async {
  try {
    if (token != null) {
      final response = await http.patch(
        Uri.parse('https://api.studenthub.dev/api/proposal/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{'statusFlag': statusFlag}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
      } else {
        print('Failed to update proposal: ${response.body}');
      }
    }
  } catch (error) {
    print(error);
  }
}

Future<void> createProposal(int projectId, int studentId, String coverLetter, String? token) async {
  try {
    if (token != null) {
      final response = await http.post(
        Uri.parse('https://api.studenthub.dev/api/proposal'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'projectId': projectId,
          'studentId': studentId,
          'coverLetter': coverLetter,
        }),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
      } else {
        print('Failed to update proposal: ${response.body}');
      }
    }
  } catch (error) {
    print(error);
  }
}
