import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/profile/multi_select.dart';
import 'package:studenthub/models/Experience.dart';
import 'package:studenthub/models/SkillSet.dart';
import 'package:studenthub/pages/profile/profile_input_step_3_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:studenthub/utils/student_profile_input_provider.dart';

const Color _green = Color(0xff296e48);

class ProfileInputStep2Screen extends StatefulWidget {
  const ProfileInputStep2Screen({Key? key}) : super(key: key);

  @override
  State<ProfileInputStep2Screen> createState() =>
      _ProfileInputStep2ScreenState();
}

class _ProfileInputStep2ScreenState extends State<ProfileInputStep2Screen> {
  bool isLoading = false;
  bool isSubmitting = false;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startMonthController;
  late TextEditingController endMonthController;
  List<SkillSet?> selectedSkills = [];

  List<SkillSet> _allSkillSets = [];

  Future<void> getAllSkillSets() async {
    setState(() {
      isLoading = true;
    });

    try {
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
                          final List<Experience> experiences =
                              Provider.of<StudentProfileInputProvider>(context,
                                      listen: false)
                                  .experiences;
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
                          Provider.of<StudentProfileInputProvider>(context,
                                  listen: false)
                              .setExperience(experiences);
                          setState(() {
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

  @override
  void initState() {
    super.initState();
    getAllSkillSets();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    startMonthController = TextEditingController();
    endMonthController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    startMonthController.dispose();
    endMonthController.dispose();
    super.dispose();
  }

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
                AppLocalizations.of(context)!.experiences,
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
                        final newLanguageObj = await openExperienceDialog(null);
                        if (newLanguageObj == null) return;
                        if (newLanguageObj['title'] == null ||
                            newLanguageObj['title'].isEmpty) {
                          return;
                        }
                        if (newLanguageObj['startMonth'] == null ||
                            newLanguageObj['startMonth'].isEmpty) return;
                        if (newLanguageObj['endMonth'] == null ||
                            newLanguageObj['endMonth'].isEmpty) return;

                        final experiences =
                            Provider.of<StudentProfileInputProvider>(context,
                                    listen: false)
                                .experiences;
                        experiences.add(Experience(
                            title: newLanguageObj['title'],
                            description: newLanguageObj['description'],
                            startMonth: newLanguageObj['startMonth'],
                            endMonth: newLanguageObj['endMonth'],
                            skillSets: newLanguageObj['skillSets']));
                        Provider.of<StudentProfileInputProvider>(context,
                                listen: false)
                            .setExperience(experiences);
                      },
                    )
                  ],
                ),
              ],
            ),
            ...Provider.of<StudentProfileInputProvider>(context)
                .experiences
                .asMap()
                .entries
                .map((entry) => Card(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 160,
                                      margin: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        entry.value.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        '${entry.value.startMonth} - ${entry.value.endMonth}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
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
                                        padding: const EdgeInsets.all(2),
                                      ),
                                      child: const Icon(Icons.edit),
                                      onPressed: () async {
                                        int index = entry.key;
                                        final experiences = Provider.of<
                                                    StudentProfileInputProvider>(
                                                context,
                                                listen: false)
                                            .experiences;
                                        titleController.value =
                                            titleController.value.copyWith(
                                                text: experiences[index].title,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset:
                                                            experiences[index]
                                                                .title
                                                                .length));
                                        descriptionController.value =
                                            descriptionController.value
                                                .copyWith(
                                                    text: experiences[index]
                                                        .description,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: experiences[
                                                                    index]
                                                                .description
                                                                .length));
                                        startMonthController.value =
                                            startMonthController.value.copyWith(
                                                text: experiences[index]
                                                    .startMonth,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset:
                                                            experiences[index]
                                                                .startMonth
                                                                .length));
                                        endMonthController.value =
                                            endMonthController.value.copyWith(
                                                text:
                                                    experiences[index].endMonth,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset:
                                                            experiences[index]
                                                                .endMonth
                                                                .length));
                                        List<SkillSet?> skillSets = [];
                                        for (SkillSet skillSet
                                            in experiences[index].skillSets) {
                                          skillSets.add(_allSkillSets
                                              .firstWhere((element) =>
                                                  element.id == skillSet.id));
                                        }

                                        setState(() {
                                          selectedSkills = skillSets
                                              .whereType<SkillSet>()
                                              .toList();
                                        });

                                        await openExperienceDialog(index);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(2),
                                      ),
                                      child: const Icon(Icons.delete),
                                      onPressed: () {
                                        final List<
                                            Experience> experiences = Provider
                                                .of<StudentProfileInputProvider>(
                                                    context,
                                                    listen: false)
                                            .experiences;
                                        experiences.removeAt(entry.key);
                                        Provider.of<StudentProfileInputProvider>(
                                                context,
                                                listen: false)
                                            .setExperience(experiences);
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
                            Wrap(
                              spacing: 10,
                              children: entry.value.skillSets
                                  .map((skillSet) => Chip(
                                      label: Text(_allSkillSets
                                          .firstWhere((element) =>
                                              element.id == skillSet.id)
                                          .name)))
                                  .toList(),
                            )
                          ],
                        )))),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProfileInputStep3Screen()),
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
