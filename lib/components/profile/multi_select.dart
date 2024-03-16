import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

const Color _green = Color(0xFF12B28C);

class Skill {
  final int id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });
}
class MultiSelect extends StatefulWidget {
  const MultiSelect({Key? key}) : super(key: key);


  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  static final List<Skill> _skills = [
    Skill(id: 1, name: "C++"),
    Skill(id: 2, name: "C#"),
    Skill(id: 3, name: "Flutter"),
    Skill(id: 4, name: "NodeJS"),
    Skill(id: 5, name: "PHP"),
    Skill(id: 6, name: "Dart"),
    Skill(id: 7, name: "Java"),
    Skill(id: 8, name: "React"),
    Skill(id: 9, name: "AWS"),
    Skill(id: 10, name: "MySQL"),
    Skill(id: 11, name: "CI/CD"),
    Skill(id: 12, name: "Go"),
    Skill(id: 13, name: "Kotlin"),
  ];
  final _items = _skills
      .map((skill) => MultiSelectItem<Skill>(skill, skill.name))
      .toList();
  List<Object?> _selectedSkills = [];

  @override
  void initState() {
    super.initState();
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
                MultiSelectBottomSheetField(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.CHIP,
                  searchable: true,
                  buttonText: const Text("Choose your skills"),
                  title: const Text("Skills"),
                  items: _items,
                  onConfirm: (values) {
                    _selectedSkills = values;
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {
                      setState(() {
                        _selectedSkills.remove(value);
                      });
                    },
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
