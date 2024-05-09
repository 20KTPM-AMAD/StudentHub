import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studenthub/models/TechStack.dart';

const Color _green = Color(0xff296e48);

class Dropdown extends StatefulWidget {
  final Function(TechStack) onSelected;
  final TechStack? initialSelection;
  const Dropdown({
    super.key,
    this.initialSelection,
    required this.onSelected,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  List<TechStack> _techStacks = [];
  bool isLoading = false;
  TechStack? selectedTechStack;

  Future<void> getAllSkillSets() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http
          .get(Uri.parse('http://34.16.137.128/api/techstack/getAllTechStack'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['result'] is List) {
          setState(() {
            _techStacks = jsonResponse['result']
                .map<TechStack>((skill) => TechStack(
                      id: skill['id'],
                      name: skill['name'],
                    ))
                .toList();
            if (widget.initialSelection != null) {
              selectedTechStack = _techStacks.firstWhere(
                  (element) => element.id == widget.initialSelection!.id);
            } else {
              selectedTechStack = _techStacks.first;
            }
          });
        } else {
          print('Response is not a list of projects');
        }
      }
    } catch (error) {
      print('Failed to get list skill Set: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedTechStack = widget.initialSelection;
    getAllSkillSets();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<TechStack>(
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
      initialSelection: selectedTechStack,
      onSelected: (TechStack? value) {
        // This is called when the user selects an item.
        widget.onSelected(value!);
      },
      dropdownMenuEntries:
          _techStacks.map<DropdownMenuEntry<TechStack>>((TechStack value) {
        return DropdownMenuEntry<TechStack>(value: value, label: value.name);
      }).toList(),
    );
  }
}
