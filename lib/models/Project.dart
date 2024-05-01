
import 'dart:convert';

import 'package:studenthub/models/Proposal.dart';
import 'package:http/http.dart' as http;

class Project {
  int id;
  int companyId;
  String title;
  String description;
  String? companyName;
  int? typeFlag;
  int projectScopeFlag;
  int numberOfStudents;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  int? countProposals;
  int? countMessages;
  int? countHired;

  bool? isFavorite;

  List<Proposal>? proposals;

  Project(
      this.id,
      this.companyId,
      this.title,
      this.description,
      this.companyName,
      this.typeFlag,
      this.projectScopeFlag,
      this.numberOfStudents,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.countProposals,
      this.countMessages,
      this.countHired,
      this.isFavorite);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['projectId'] ?? json['id'],
      int.parse(json['companyId']), // Parsing companyId as integer
      json['title'],
      json['description'],
      json['companyName'] ?? '',
      json['typeFlag'] ?? 0, // Check if typeFlag is null, if so, assign 0
      json['projectScopeFlag'],
      json['numberOfStudents'],
      DateTime.parse(json['createdAt']),
      DateTime.parse(json['updatedAt']),
      json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      json['countProposals'],
      json['countMessages'],
      json['countHired'],
      json['isFavorite'],
    );
  }
}

Future<Project> getProjectById(
    int id, String token) async {
  
  final uri = Uri.https('api.studenthub.dev', '/api/project/$id');

  final response = await http.get(uri, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    final project = Project.fromJson(jsonResponse['result']);

    return project;
  } else {
    throw Exception('Failed to load project');
  }
}