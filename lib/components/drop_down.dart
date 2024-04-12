import 'package:flutter/material.dart';

const Color _green = Color(0xff296e48);

const List<String> list = <String>[
  'Fullstack Engineer',
  'Frontend Developer',
  'Backend Developer',
];

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: 350,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(10),
        constraints: BoxConstraints.expand(height: 50),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 1.2,
            color: _green,
          ),
        ),
      ),
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
