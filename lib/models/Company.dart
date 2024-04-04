class Company {
  int id;
  int userId;
  String companyName;
  String website;
  String description;
  int size;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  Company(
      this.id,
      this.userId,
      this.companyName,
      this.website,
      this.description,
      this.size,
      this.createdAt,
      this.updatedAt,
      this.deletedAt);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      json['id'],
      json['userId'],
      json['companyName'],
      json['website'],
      json['description'],
      json['size'],
      DateTime.parse(json['createdAt']),
      DateTime.parse(json['updatedAt']),
      json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}