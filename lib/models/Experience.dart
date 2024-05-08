import 'package:studenthub/models/SkillSet.dart';

class Experience {
  late String title;
  late String startMonth;
  late String endMonth;
  late String description;
  late List<SkillSet> skillSets = [];

  Experience(
      {required this.title,
      required this.startMonth,
      required this.endMonth,
      required this.description,
      required this.skillSets});

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'] as String,
      startMonth: json['startMonth'] as String,
      endMonth: json['endMonth'] as String,
      description: json['description'] as String,
      skillSets: (json['skillSets'] as List<dynamic>?)
              ?.map((skillSet) =>
                  SkillSet.fromJson(skillSet as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startMonth': startMonth,
      'endMonth': endMonth,
      'description': description,
      'skillSets': skillSets.map((skillSet) => skillSet.id).toList(),
    };
  }
}
