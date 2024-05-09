class Language {
  late String languageName;
  late String level;

  Language({
    required this.languageName,
    required this.level,
  });
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageName: json['languageName'] as String,
      level: json['level'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languageName': languageName,
      'level': level,
    };
  }
}
