import 'package:flutter/foundation.dart';
import 'package:studenthub/models/Education.dart';
import 'package:studenthub/models/Experience.dart';
import 'package:studenthub/models/Language.dart';

class StudentProfileInputProvider with ChangeNotifier {
  String? _techStackId;

  List<String> _skillSetIds = [];

  List<Language> _languages = [];

  List<Education> _educations = [];

  List<Experience> _experiences = [];

  String? get techStackId => _techStackId;

  List<String> get skillSetIds => _skillSetIds;

  List<Language> get languages => _languages;

  List<Education> get educations => _educations;

  List<Experience> get experiences => _experiences;

  void setTechStackId(String techStackId) {
    _techStackId = techStackId;
    notifyListeners();
  }

  void addSkillSetId(String skillSetId) {
    _skillSetIds?.add(skillSetId);
    notifyListeners();
  }

  void removeSkillSetId(String skillSetId) {
    _skillSetIds?.remove(skillSetId);
    notifyListeners();
  }

  void addLanguage(Language language) {
    _languages.add(language);
    notifyListeners();
  }

  void removeLanguage(Language language) {
    _languages.remove(language);
    notifyListeners();
  }

  void addEducation(Education education) {
    _educations.add(education);
    notifyListeners();
  }

  void removeEducation(Education education) {
    _educations.remove(education);
    notifyListeners();
  }

  void addExperience(Experience experience) {
    _experiences.add(experience);
    notifyListeners();
  }

  void removeExperience(Experience experience) {
    _experiences.remove(experience);
    notifyListeners();
  }

  void clear() {
    _techStackId = null;
    _skillSetIds = [];
    _languages = [];
    _educations = [];
    _experiences = [];
    notifyListeners();
  }
}
