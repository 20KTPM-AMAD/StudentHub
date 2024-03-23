import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Text(AppLocalizations.of(context)!.its_just_me),
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
          title: Text(AppLocalizations.of(context)!.two_nine_employees),
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
          title: Text(AppLocalizations.of(context)!.ten_ninetynine_employees),
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
          title: Text(AppLocalizations.of(context)!.hundred_thousand_employees),
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
          title: Text(AppLocalizations.of(context)!.more_than_thousand_employees),
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