import 'package:flutter/material.dart';

enum Range {
  ItIsJustMe,
  TwoToNineEmployees,
  TenToNinetyNineEmployees,
  HundredToOneThousandEmployees,
  MoreThanOneThousandEmployees
}

class RadioButtonGroup extends StatefulWidget {
  const RadioButtonGroup({super.key});

  @override
  State<RadioButtonGroup> createState() => _RadioButtonGroupeState();
}

class _RadioButtonGroupeState extends State<RadioButtonGroup> {
  Range? _range = Range.ItIsJustMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('It’s just me'),
          leading: Radio<Range>(
            value: Range.ItIsJustMe,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('2-9 employees'),
          leading: Radio<Range>(
            value: Range.TwoToNineEmployees,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('10-99 employees'),
          leading: Radio<Range>(
            value: Range.TenToNinetyNineEmployees,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('100-1000 employees'),
          leading: Radio<Range>(
            value: Range.HundredToOneThousandEmployees,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('More than 1000 employees'),
          leading: Radio<Range>(
            value: Range.MoreThanOneThousandEmployees,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        )
      ],
    );
  }
}