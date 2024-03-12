import 'package:flutter/material.dart';

enum Range {
  LessThanOneMonth,
  OneToThreeMonths,
  ThreeToSixMonths,
  MoreThanSixMonths,
}

class RadioButtonGroupProjectLength extends StatefulWidget {
  const RadioButtonGroupProjectLength({super.key});

  @override
  State<RadioButtonGroupProjectLength> createState() => _RadioButtonGroupeState();
}

class _RadioButtonGroupeState extends State<RadioButtonGroupProjectLength> {
  Range? _range = Range.LessThanOneMonth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Less than one month'),
          leading: Radio<Range>(
            value: Range.LessThanOneMonth,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('1 to 3 months'),
          leading: Radio<Range>(
            value: Range.OneToThreeMonths,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('3 to 6 months'),
          leading: Radio<Range>(
            value: Range.ThreeToSixMonths,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('More than 6 months'),
          leading: Radio<Range>(
            value: Range.MoreThanSixMonths,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
            },
          ),
        ),
      ],
    );
  }
}