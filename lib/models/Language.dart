class Language {
  late int id;
  late String languageName;
  late String level;

  Language(this.id, this.languageName, this.level);

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      json['id'] as int,
      json['languageName'] as String,
      json['level'] as String,
    );
  }
}
