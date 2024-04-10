import 'Education.dart';
import 'TechStack.dart';

class Student {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? deletedAt;
  final int userId;
  final String fullname;
  final int techStackId;
  final String? resume;
  final String? transcript;
  final TechStack techStack;
  final List<Education> educations;

  Student({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.fullname,
    required this.techStackId,
    this.resume,
    this.transcript,
    required this.techStack,
    required this.educations,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'],
      userId: json['userId'],
      fullname: 'abc',
      techStackId: json['techStackId'],
      resume: json['resume'],
      transcript: json['transcript'],
      techStack: TechStack.fromJson(json['techStack']),
      educations: (json['educations'] as List<dynamic>).map((e) => Education.fromJson(e)).toList(),
    );
  }
}