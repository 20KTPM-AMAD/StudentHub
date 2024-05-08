import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/models/SkillSet.dart';

const Color _green = Color(0xff296e48);

class MultiSelect extends StatefulWidget {
  final List<SkillSet?> selectedSkills;
  final Function(List<SkillSet?>) setSkillSets;

  const MultiSelect(
      {Key? key, required this.setSkillSets, required this.selectedSkills})
      : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<SkillSet> _skills = [];
  bool isLoading = false;

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
            _skills = jsonResponse['result']
                .map<SkillSet>(
                    (data) => SkillSet(id: data['id'], name: data['name']))
                .toList();
            _items = _skills
                .map((skill) => MultiSelectItem<SkillSet>(skill, skill.name))
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

  List<MultiSelectItem<SkillSet>> _items = [];

  @override
  void initState() {
    super.initState();
    getAllSkillSets();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: _green,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                MultiSelectBottomSheetField<SkillSet?>(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.CHIP,
                  searchable: true,
                  buttonText:
                      Text(AppLocalizations.of(context)!.choose_your_skills),
                  title: Text(AppLocalizations.of(context)!.skills),
                  items: _items,
                  onConfirm: (values) {
                    widget.setSkillSets(values);
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {},
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
