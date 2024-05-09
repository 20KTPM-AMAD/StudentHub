class Education {
  late String schoolName;
  late String startYear;
  late String endYear;

  Education({
    required this.schoolName,
    required this.startYear,
    required this.endYear,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      schoolName: json['schoolName'],
      startYear: json['startYear'].toString(),
      endYear: json['endYear'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'startYear': startYear,
      'endYear': endYear,
    };
  }
}
