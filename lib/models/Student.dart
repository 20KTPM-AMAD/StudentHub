import 'package:studenthub/models/Experience.dart';
import 'package:studenthub/models/Language.dart';
import 'package:studenthub/models/SkillSet.dart';

import 'Education.dart';
import 'TechStack.dart';

class Student {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? deletedAt;
  final int userId;
  final int techStackId;
  final String? resume;
  final String? transcript;
  final TechStack techStack;
  final List<Education>? educations;
  final List<SkillSet>? skillSets;
  final List<Language>? languages;
  final List<Experience>? experiences;

  Student({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.techStackId,
    this.resume,
    this.transcript,
    required this.techStack,
    this.educations,
    this.skillSets,
    this.languages,
    this.experiences,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    List<Education>? educationsList;
    List<SkillSet>? skillSetsList;
    List<Language>? languagesList;
    List<Experience>? experiencesList;

    if (json['educations'] != null) {
      educationsList = (json['educations'] as List<dynamic>)
          .map((e) => Education.fromJson(e))
          .toList();
    }

    if (json['skillSets'] != null) {
      skillSetsList = (json['skillSets'] as List<dynamic>)
          .map((e) => SkillSet.fromJson(e))
          .toList();
    }

    if (json['languages'] != null) {
      languagesList = (json['languages'] as List<dynamic>)
          .map((e) => Language.fromJson(e))
          .toList();
    }

    if (json['experiences'] != null) {
      experiencesList = (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e))
          .toList();
    }

    return Student(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'],
      userId: json['userId'],
      techStackId: json['techStackId'],
      resume: json['resume'],
      transcript: json['transcript'],
      techStack: TechStack.fromJson(json['techStack']),
      educations: educationsList,
      skillSets: skillSetsList,
      languages: languagesList,
      experiences: experiencesList,
    );
  }

}
