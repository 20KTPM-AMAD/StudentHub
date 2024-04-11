class Experience {
  late int? id;
  late String title;
  late String startMonth;
  late String endMonth;
  late String description;
  late List<String> skillSetIds;

  Experience(
      {this.id,
      required this.title,
      required this.startMonth,
      required this.endMonth,
      required this.description,
      required this.skillSetIds});

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as int,
      title: json['title'] as String,
      startMonth: json['startMonth'] as String,
      endMonth: json['endMonth'] as String,
      description: json['description'] as String,
      skillSetIds: (json['skillSetIds'] as List<dynamic>?)
              ?.map((skillSetId) => skillSetId as String)
              .toList() ??
          [],
    );
  }
}
