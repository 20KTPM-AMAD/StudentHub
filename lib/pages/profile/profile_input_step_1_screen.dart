import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/drop_down.dart';
import 'package:studenthub/components/profile/multi_select.dart';
import 'package:studenthub/models/Education.dart';
import 'package:studenthub/models/Language.dart';
import 'package:studenthub/models/SkillSet.dart';
import 'package:studenthub/models/TechStack.dart';
import 'package:studenthub/pages/profile/profile_input_step_2_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/student_profile_input_provider.dart';

const Color _green = Color(0xff296e48);

class ProfileInputStep1Screen extends StatefulWidget {
  const ProfileInputStep1Screen({Key? key}) : super(key: key);

  @override
  State<ProfileInputStep1Screen> createState() =>
      _ProfileInputStep1ScreenState();
}

class _ProfileInputStep1ScreenState extends State<ProfileInputStep1Screen> {
  @override
  void initState() {
    super.initState();
    languageNameController = TextEditingController();
    languageLevelController = TextEditingController();
    schoolNameController = TextEditingController();
    startYearController = TextEditingController();
    endYearController = TextEditingController();
  }

  @override
  void dispose() {
    languageNameController.dispose();
    languageLevelController.dispose();
    schoolNameController.dispose();
    startYearController.dispose();
    endYearController.dispose();
    super.dispose();
  }

  late TextEditingController languageNameController;
  late TextEditingController languageLevelController;
  late TextEditingController schoolNameController;
  late TextEditingController startYearController;
  late TextEditingController endYearController;

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
                          final language =
                              Provider.of<StudentProfileInputProvider>(context,
                                      listen: false)
                                  .languages;
                          language[selectedLanguageIndex].languageName =
                              languageNameController.text;
                          language[selectedLanguageIndex].level =
                              languageLevelController.text;
                          Provider.of<StudentProfileInputProvider>(context,
                                  listen: false)
                              .setLanguage(language);
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
                          final education =
                              Provider.of<StudentProfileInputProvider>(context,
                                      listen: false)
                                  .educations;
                          education[selectedEducationIndex].schoolName =
                              schoolNameController.text;
                          education[selectedEducationIndex].startYear =
                              startYearController.text;
                          education[selectedEducationIndex].endYear =
                              endYearController.text;
                          Provider.of<StudentProfileInputProvider>(context,
                                  listen: false)
                              .setEducation(education);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.welcome_to_studenthub,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            Text(AppLocalizations.of(context)!.intro_four,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.techstack,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Dropdown(
              initialSelection: null,
              onSelected: (TechStack value) {
                Provider.of<StudentProfileInputProvider>(context, listen: false)
                    .setTechStackId(value);
              },
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.skillset,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // select
            MultiSelect(
              selectedSkills:
                  Provider.of<StudentProfileInputProvider>(context).skillSets,
              setSkillSets: (List<SkillSet?> values) {
                Provider.of<StudentProfileInputProvider>(context, listen: false)
                    .setSkillSets(values);
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
                        final newLanguageObj = await openLanguageDialog(null);
                        if (newLanguageObj == null) return;
                        if (newLanguageObj['languageName'] == null ||
                            newLanguageObj['languageName'].isEmpty) {
                          return;
                        }
                        if (newLanguageObj['level'] == null ||
                            newLanguageObj['level'].isEmpty) return;

                        final languages =
                            Provider.of<StudentProfileInputProvider>(context,
                                    listen: false)
                                .languages;
                        languages.add(Language(
                            languageName: newLanguageObj['languageName'],
                            level: newLanguageObj['level']));
                        Provider.of<StudentProfileInputProvider>(context,
                                listen: false)
                            .setLanguage(languages);
                      },
                    ),
                  ],
                ),
              ],
            ),

            ...Provider.of<StudentProfileInputProvider>(context)
                .languages
                .map((e) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: const EdgeInsets.only(left: 12),
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
                                    int index = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .languages
                                        .indexOf(e);
                                    final languages = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .languages;
                                    languageNameController.value =
                                        languageNameController.value.copyWith(
                                            text: languages[index].languageName,
                                            selection: TextSelection.collapsed(
                                                offset: languages[index]
                                                    .languageName
                                                    .length));
                                    languageLevelController.value =
                                        languageLevelController.value.copyWith(
                                            text: languages[index].level,
                                            selection: TextSelection.collapsed(
                                                offset: languages[index]
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
                                    int index = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .languages
                                        .indexOf(e);
                                    final languages = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .languages;
                                    languages.removeAt(index);
                                    Provider.of<StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .setLanguage(languages);
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
                        final newEducationObj = await openEducationDialog(null);
                        if (newEducationObj == null) return;
                        if (newEducationObj['schoolName'] == null ||
                            newEducationObj['schoolName'].isEmpty) {
                          return;
                        }
                        if (newEducationObj['startYear'] == null ||
                            newEducationObj['startYear'].isEmpty) return;
                        if (newEducationObj['endYear'] == null ||
                            newEducationObj['endYear'].isEmpty) return;

                        final educations =
                            Provider.of<StudentProfileInputProvider>(context,
                                    listen: false)
                                .educations;

                        educations.add(Education(
                            schoolName: newEducationObj['schoolName'],
                            startYear: newEducationObj['startYear'],
                            endYear: newEducationObj['endYear']));
                        Provider.of<StudentProfileInputProvider>(context,
                                listen: false)
                            .setEducation(educations);
                      },
                    )
                  ],
                ),
              ],
            ),
            ...Provider.of<StudentProfileInputProvider>(context)
                .educations
                .map((e) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: const EdgeInsets.only(left: 12),
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
                                    int index = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .educations
                                        .indexOf(e);
                                    final educations = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .educations;
                                    schoolNameController.value =
                                        schoolNameController.value.copyWith(
                                            text: educations[index].schoolName,
                                            selection: TextSelection.collapsed(
                                                offset: educations[index]
                                                    .schoolName
                                                    .length));
                                    startYearController.value =
                                        startYearController.value.copyWith(
                                            text: educations[index].startYear,
                                            selection: TextSelection.collapsed(
                                                offset: educations[index]
                                                    .startYear
                                                    .length));
                                    endYearController.value =
                                        endYearController.value.copyWith(
                                            text: educations[index].endYear,
                                            selection: TextSelection.collapsed(
                                                offset: educations[index]
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
                                    int index = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .educations
                                        .indexOf(e);
                                    final educations = Provider.of<
                                                StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .educations;
                                    educations.removeAt(index);
                                    Provider.of<StudentProfileInputProvider>(
                                            context,
                                            listen: false)
                                        .setEducation(educations);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),

            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    final skillSets = Provider.of<StudentProfileInputProvider>(
                            context,
                            listen: false)
                        .skillSets;
                    log(Provider.of<StudentProfileInputProvider>(context,
                            listen: false)
                        .techStack
                        .toString());
                    List<String> skills = [];
                    for (var skill in skillSets) {
                      skills.add(skill!.id.toString());
                    }
                    log(skills.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProfileInputStep2Screen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _green, foregroundColor: Colors.white),
                  child: Text(AppLocalizations.of(context)!.next,
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
