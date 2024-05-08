import 'package:flutter/foundation.dart';
import 'package:studenthub/models/Education.dart';
import 'package:studenthub/models/Experience.dart';
import 'package:studenthub/models/Language.dart';
import 'package:studenthub/models/SkillSet.dart';
import 'package:studenthub/models/TechStack.dart';

class StudentProfileInputProvider with ChangeNotifier {
  TechStack? _techStack;

  List<SkillSet?> _skillSets = [];

  List<Language> _languages = [];

  List<Education> _educations = [];

  List<Experience> _experiences = [];

  TechStack? get techStack => _techStack;

  List<SkillSet?> get skillSets => _skillSets;

  List<Language> get languages => _languages;

  List<Education> get educations => _educations;

  List<Experience> get experiences => _experiences;

  void setTechStackId(TechStack techStack) {
    _techStack = techStack;
    notifyListeners();
  }

  void setSkillSets(List<SkillSet?> skillSets) {
    _skillSets = skillSets;
    notifyListeners();
  }

  void setLanguage(List<Language> languages) {
    _languages = languages;
    notifyListeners();
  }

  void setEducation(List<Education> educations) {
    _educations = educations;
    notifyListeners();
  }

  setExperience(List<Experience> experiences) {
    _experiences = experiences;
    notifyListeners();
  }

  void clear() {
    _techStack = null;
    _skillSets = [];
    _languages = [];
    _educations = [];
    _experiences = [];
    notifyListeners();
  }
}
