class Project {
  int id;
  int companyId;
  String title;
  String description;
  int typeFlag;
  int projectScopeFlag;
  int numberOfStudents;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  int? countProposals;
  int? countMessages;
  int? countHired;

  Project(
      this.id,
      this.companyId,
      this.title,
      this.description,
      this.typeFlag,
      this.projectScopeFlag,
      this.numberOfStudents,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.countProposals,
      this.countMessages,
      this.countHired);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['id'],
      int.parse(json['companyId']), // Parsing companyId as integer
      json['title'],
      json['description'],
      json['typeFlag'],
      json['projectScopeFlag'],
      json['numberOfStudents'],
      DateTime.parse(json['createdAt']),
      DateTime.parse(json['updatedAt']),
      json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      json['countProposals'],
      json['countMessages'],
      json['countHired'],
    );
  }
}