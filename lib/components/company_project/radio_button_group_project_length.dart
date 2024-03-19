import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Text(AppLocalizations.of(context)!.less_than_one_month),
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
          title: Text(AppLocalizations.of(context)!.one_to_three_months,),
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
          title: Text(AppLocalizations.of(context)!.three_to_six_months),
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
          title: Text(AppLocalizations.of(context)!.more_than_six_months),
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