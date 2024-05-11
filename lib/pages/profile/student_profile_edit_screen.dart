import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:studenthub/components/drop_down.dart';
import 'package:studenthub/components/profile/multi_select.dart';
import 'package:studenthub/models/Education.dart';
import 'package:studenthub/models/Experience.dart';
import 'package:studenthub/models/Language.dart';
import 'package:studenthub/models/SkillSet.dart';
import 'package:studenthub/models/TechStack.dart';
import 'package:studenthub/models/User.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/student_profile_input_provider.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class StudentProfileEditScreen extends StatefulWidget {
  const StudentProfileEditScreen({Key? key}) : super(key: key);

  @override
  StudentProfileEditScreenState createState() =>
      StudentProfileEditScreenState();
}

class StudentProfileEditScreenState extends State<StudentProfileEditScreen> {
  bool isLoading = false;

  Future<void> getAllSkillSets() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http
          .get(Uri.parse('http://34.16.137.128/api/skillset/getAllSkillSet'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['result'] is List) {
          setState(() {
            _allSkillSets = jsonResponse['result']
                .map<SkillSet>(
                    (data) => SkillSet(id: data['id'], name: data['name']))
                .toList();
          });
          inspect(_allSkillSets);
        } else {
          print('Response is not a list of projects');
        }
      }
    } catch (error) {
      print('Failed to get list skill Set: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>?> openLanguageDialog(
          int? selectedLanguageIndex) =>
      showDialog<Map<String, dynamic>>(
          context: context,
          builder: (context) => AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Text(selectedLanguageIndex is int
                    ? "Edit Language"
                    : 'Add New Language:'),
                content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: "Enter language name..."),
                          controller: languageNameController,
                        ),
                        TextFormField(
                          initialValue: null,
                          decoration: const InputDecoration(
                              hintText: "Enter language level..."),
                          controller: languageLevelController,
                        ),
                      ],
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        languageNameController.clear();
                        languageLevelController.clear();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        if (selectedLanguageIndex is int) {
                          final languages = language;
                          language[selectedLanguageIndex].languageName =
                              languageNameController.text;
                          language[selectedLanguageIndex].level =
                              languageLevelController.text;
                          setState(() {
                            language = languages;
                          });
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop({
                            'languageName': languageNameController.text,
                            'level': languageLevelController.text
                          });
                        }

                        languageNameController.clear();
                        languageLevelController.clear();
                      },
                      child: const Text("Confirm"))
                ],
              ));

  Future<Map<String, dynamic>?> openEducationDialog(
          int? selectedEducationIndex) =>
      showDialog<Map<String, dynamic>>(
          context: context,
          builder: (context) => AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Text(selectedEducationIndex is int
                    ? "Edit Education"
                    : 'Add New Education:'),
                content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: "Enter school name..."),
                          controller: schoolNameController,
                        ),
                        TextFormField(
                          initialValue: null,
                          decoration: const InputDecoration(
                              hintText: "Enter start year..."),
                          controller: startYearController,
                        ),
                        TextFormField(
                          initialValue: null,
                          decoration: const InputDecoration(
                              hintText: "Enter end year..."),
                          controller: endYearController,
                        ),
                      ],
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        schoolNameController.clear();
                        startYearController.clear();
                        endYearController.clear();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        if (selectedEducationIndex is int) {
                          final educations = education;
                          educations[selectedEducationIndex].schoolName =
                              schoolNameController.text;
                          educations[selectedEducationIndex].startYear =
                              startYearController.text;
                          educations[selectedEducationIndex].endYear =
                              endYearController.text;
                          setState(() {
                            education = educations;
                          });
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop({
                            'schoolName': schoolNameController.text,
                            'startYear': startYearController.text,
                            'endYear': endYearController.text
                          });
                        }
                        schoolNameController.clear();
                        startYearController.clear();
                        endYearController.clear();
                      },
                      child: const Text("Confirm"))
                ],
              ));

  Future<Map<String, dynamic>?> openExperienceDialog(
          int? selectedExperienceIndex) =>
      showDialog<Map<String, dynamic>>(
          context: context,
          builder: (context) => AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Text(selectedExperienceIndex is int
                    ? "Edit Experience:"
                    : 'Add New Experience:'),
                content: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration:
                          const InputDecoration(hintText: "Enter title..."),
                      controller: titleController,
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: 5, //or null
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: const OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: _green),
                        ),
                        hintText:
                            AppLocalizations.of(context)!.hint_description,
                      ),
                    ),
                    TextFormField(
                      initialValue: null,
                      decoration: const InputDecoration(
                          hintText: "Enter start month..."),
                      controller: startMonthController,
                    ),
                    TextFormField(
                      initialValue: null,
                      decoration:
                          const InputDecoration(hintText: "Enter end month..."),
                      controller: endMonthController,
                    ),
                    MultiSelect(
                      selectedSkills: selectedSkills,
                      setSkillSets: (List<SkillSet?> values) {
                        setState(() {
                          selectedSkills = values;
                        });
                      },
                    ),
                  ],
                )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        titleController.clear();
                        descriptionController.clear();
                        startMonthController.clear();
                        endMonthController.clear();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        List<SkillSet> selectedSkillSets =
                            selectedSkills.whereType<SkillSet>().toList();
                        if (selectedExperienceIndex is int) {
                          final List<Experience> experiences = experience;
                          experiences[selectedExperienceIndex].description =
                              descriptionController.text;
                          experiences[selectedExperienceIndex].title =
                              titleController.text;
                          experiences[selectedExperienceIndex].startMonth =
                              startMonthController.text;
                          experiences[selectedExperienceIndex].endMonth =
                              endMonthController.text;
                          experiences[selectedExperienceIndex].skillSets =
                              selectedSkillSets;

                          setState(() {
                            experience = experiences;
                            selectedSkills = [];
                          });
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop({
                            'title': titleController.text,
                            'startMonth': startMonthController.text,
                            'endMonth': endMonthController.text,
                            'description': descriptionController.text,
                            'skillSets': selectedSkillSets
                          });
                        }
                        titleController.clear();
                        descriptionController.clear();
                        startMonthController.clear();
                        endMonthController.clear();
                        setState(() {
                          selectedSkills = [];
                        });
                      },
                      child: const Text("Confirm"))
                ],
              ));

  TechStack? techStack;
  List<SkillSet?> skillSets = [];
  List<Language> language = [];
  List<Education> education = [];
  List<Experience> experience = [];
  late TextEditingController languageNameController;
  late TextEditingController languageLevelController;
  late TextEditingController schoolNameController;
  late TextEditingController startYearController;
  late TextEditingController endYearController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startMonthController;
  late TextEditingController endMonthController;
  List<SkillSet?> selectedSkills = [];

  List<SkillSet> _allSkillSets = [];

  @override
  void initState() {
    super.initState();
    techStack = Provider.of<AuthProvider>(context, listen: false)
        .loginUser!
        .student!
        .techStack;
    skillSets = Provider.of<AuthProvider>(context, listen: false)
        .loginUser!
        .student!
        .skillSets!;
    language = Provider.of<AuthProvider>(context, listen: false)
        .loginUser!
        .student!
        .languages!;
    education = Provider.of<AuthProvider>(context, listen: false)
        .loginUser!
        .student!
        .educations!;
    experience = Provider.of<AuthProvider>(context, listen: false)
        .loginUser!
        .student!
        .experiences!;
    inspect(experience);
    languageNameController = TextEditingController();
    languageLevelController = TextEditingController();
    schoolNameController = TextEditingController();
    startYearController = TextEditingController();
    endYearController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    startMonthController = TextEditingController();
    endMonthController = TextEditingController();

    getAllSkillSets();
  }

  @override
  void dispose() {
    languageNameController.dispose();
    languageLevelController.dispose();
    schoolNameController.dispose();
    startYearController.dispose();
    endYearController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    startMonthController.dispose();
    endMonthController.dispose();
    super.dispose();
  }

  Future<void> updateStudentProfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final student =
          Provider.of<AuthProvider>(context, listen: false).loginUser!.student!;

      final response = await http.put(
        Uri.parse('http://34.16.137.128/api/profile/student/${student.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "techStackId": techStack!.id,
          "skillSets": skillSets.map((e) => e!.id).toList(),
        }),
      );

      if (response.statusCode != 200) {
        inspect(response);
        print('Error updating student profile');
      }

      final updateStudentLanguages = await http.put(
          Uri.parse(
              'http://34.16.137.128/api/language/updateByStudentId/${student.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            "languages": language,
          }));
      if (updateStudentLanguages.statusCode != 200) {
        print('Error updating student languages');
      }
      final updateStudentEducations = await http.put(
          Uri.parse(
              'http://34.16.137.128/api/education/updateByStudentId/${student.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            "education": education,
          }));
      if (updateStudentEducations.statusCode != 200) {
        print('Error updating student educations');
      }
      final updateStudentExperiences = await http.put(
          Uri.parse(
              'http://34.16.137.128/api/experience/updateByStudentId/${student.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            "experience": experience,
          }));
      if (updateStudentExperiences.statusCode != 200) {
        print('Error updating student experiences');
      }

      final getProfileAgain = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (getProfileAgain.statusCode == 200) {
        final jsonResponse = json.decode(getProfileAgain.body);
        Provider.of<AuthProvider>(context, listen: false)
            .setLoginUser(User.fromJson(jsonResponse['result']));
      }

      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SwitchAccountScreen(),
        ),
      );
    } catch (error) {
      print('Failed to update student profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          AppLocalizations.of(context)!.welcome_to_studenthub,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(AppLocalizations.of(context)!.techstack,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Dropdown(
                          initialSelection: techStack,
                          onSelected: (TechStack value) {
                            setState(() {
                              techStack = value;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context)!.skillset,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        // select
                        MultiSelect(
                          selectedSkills: skillSets,
                          setSkillSets: (List<SkillSet?> values) {
                            setState(() {
                              skillSets = values;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(2),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    final newLanguageObj =
                                        await openLanguageDialog(null);
                                    if (newLanguageObj == null) return;
                                    if (newLanguageObj['languageName'] ==
                                            null ||
                                        newLanguageObj['languageName']
                                            .isEmpty) {
                                      return;
                                    }
                                    if (newLanguageObj['level'] == null ||
                                        newLanguageObj['level'].isEmpty) return;

                                    setState(() {
                                      language = [
                                        ...language,
                                        Language(
                                          languageName:
                                              newLanguageObj['languageName'],
                                          level: newLanguageObj['level'],
                                        ),
                                      ];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),

                        ...language.map((e) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            e.languageName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 12),
                                            child: Text(
                                              e.level,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(2),
                                          ),
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            int index = language.indexOf(e);
                                            final languages = language;
                                            languageNameController.value =
                                                languageNameController.value
                                                    .copyWith(
                                                        text: languages[index]
                                                            .languageName,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: languages[
                                                                        index]
                                                                    .languageName
                                                                    .length));
                                            languageLevelController.value =
                                                languageLevelController.value
                                                    .copyWith(
                                                        text: languages[index]
                                                            .level,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: languages[
                                                                        index]
                                                                    .level
                                                                    .length));
                                            await openLanguageDialog(index);
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(2),
                                          ),
                                          child: const Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            int index = language.indexOf(e);
                                            final languages = language;
                                            languages.removeAt(index);
                                            setState(() {
                                              language = languages;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.education,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(2),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    final newEducationObj =
                                        await openEducationDialog(null);
                                    if (newEducationObj == null) return;
                                    if (newEducationObj['schoolName'] == null ||
                                        newEducationObj['schoolName'].isEmpty) {
                                      return;
                                    }
                                    if (newEducationObj['startYear'] == null ||
                                        newEducationObj['startYear'].isEmpty)
                                      return;
                                    if (newEducationObj['endYear'] == null ||
                                        newEducationObj['endYear'].isEmpty)
                                      return;

                                    final educations = education;

                                    educations.add(Education(
                                        schoolName:
                                            newEducationObj['schoolName'],
                                        startYear: newEducationObj['startYear'],
                                        endYear: newEducationObj['endYear']));
                                    setState(() {
                                      education = educations;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                        ...education.map((e) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            e.schoolName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 12),
                                            child: Text(
                                              '${e.startYear} - ${e.endYear}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(2),
                                          ),
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            int index = education.indexOf(e);
                                            final educations = education;
                                            schoolNameController.value =
                                                schoolNameController
                                                    .value
                                                    .copyWith(
                                                        text:
                                                            educations[index]
                                                                .schoolName,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: educations[
                                                                        index]
                                                                    .schoolName
                                                                    .length));
                                            startYearController.value =
                                                startYearController.value.copyWith(
                                                    text: educations[index]
                                                        .startYear,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: educations[
                                                                    index]
                                                                .startYear
                                                                .length));
                                            endYearController.value =
                                                endYearController.value.copyWith(
                                                    text: educations[index]
                                                        .endYear,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: educations[
                                                                    index]
                                                                .endYear
                                                                .length));
                                            await openEducationDialog(index);
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(2),
                                          ),
                                          child: const Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            int index = education.indexOf(e);
                                            final educations = education;
                                            educations.removeAt(index);
                                            setState(() {
                                              education = educations;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.project,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(2),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    final newLanguageObj =
                                        await openExperienceDialog(null);
                                    if (newLanguageObj == null) return;
                                    if (newLanguageObj['title'] == null ||
                                        newLanguageObj['title'].isEmpty) {
                                      return;
                                    }
                                    if (newLanguageObj['startMonth'] == null ||
                                        newLanguageObj['startMonth'].isEmpty)
                                      return;
                                    if (newLanguageObj['endMonth'] == null ||
                                        newLanguageObj['endMonth'].isEmpty)
                                      return;

                                    setState(() {
                                      experience = [
                                        ...experience,
                                        Experience(
                                          title: newLanguageObj['title'],
                                          description:
                                              newLanguageObj['description'],
                                          startMonth:
                                              newLanguageObj['startMonth'],
                                          endMonth: newLanguageObj['endMonth'],
                                          skillSets:
                                              newLanguageObj['skillSets'],
                                        ),
                                      ];
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                        ...experience.asMap().entries.map((entry) => Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 160,
                                              margin: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: Text(
                                                entry.value.title,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                '${entry.value.startMonth} - ${entry.value.endMonth}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                    const EdgeInsets.all(2),
                                              ),
                                              child: const Icon(Icons.edit),
                                              onPressed: () async {
                                                int index = entry.key;
                                                final experiences = experience;
                                                titleController.value =
                                                    titleController.value.copyWith(
                                                        text: experiences[index]
                                                            .title,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: experiences[
                                                                        index]
                                                                    .title
                                                                    .length));
                                                descriptionController.value =
                                                    descriptionController.value.copyWith(
                                                        text: experiences[index]
                                                            .description,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: experiences[
                                                                        index]
                                                                    .description
                                                                    .length));
                                                startMonthController.value =
                                                    startMonthController.value.copyWith(
                                                        text: experiences[index]
                                                            .startMonth,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: experiences[
                                                                        index]
                                                                    .startMonth
                                                                    .length));
                                                endMonthController.value =
                                                    endMonthController.value.copyWith(
                                                        text: experiences[index]
                                                            .endMonth,
                                                        selection: TextSelection
                                                            .collapsed(
                                                                offset: experiences[
                                                                        index]
                                                                    .endMonth
                                                                    .length));
                                                List<SkillSet?> skillSets = [];
                                                for (SkillSet skillSet
                                                    in experiences[index]
                                                        .skillSets) {
                                                  skillSets.add(_allSkillSets
                                                      .firstWhere((element) =>
                                                          element.id
                                                              .toString() ==
                                                          skillSet.id
                                                              .toString()));
                                                }

                                                setState(() {
                                                  selectedSkills = skillSets
                                                      .whereType<SkillSet>()
                                                      .toList();
                                                });

                                                await openExperienceDialog(
                                                    index);
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                    const EdgeInsets.all(2),
                                              ),
                                              child: const Icon(Icons.delete),
                                              onPressed: () {
                                                final List<Experience>
                                                    experiences = experience;
                                                experiences.removeAt(entry.key);
                                                setState(() {
                                                  experience = experiences;
                                                });
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        entry.value.description,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(spacing: 10, children: [
                                      ...entry.value.skillSets.map((e) => Chip(
                                            label: Text(e.name),
                                          ))
                                    ])
                                  ],
                                )))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[300],
                            fixedSize: const Size(120, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            updateStudentProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: _green,
                            fixedSize: const Size(120, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.edit,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(),
      ),
    );
  }
}
