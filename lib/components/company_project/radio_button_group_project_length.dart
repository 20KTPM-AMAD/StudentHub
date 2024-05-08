import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Range {
  LessThanOneMonth,
  OneToThreeMonths,
  ThreeToSixMonths,
  MoreThanSixMonths,
}

class RadioButtonGroupProjectLength extends StatefulWidget {
  final Function(Range?) onValueChanged;

  const RadioButtonGroupProjectLength({required this.onValueChanged, Key? key}) : super(key: key);

  @override
  State<RadioButtonGroupProjectLength> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroupProjectLength> {
  Range? _range;

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
              widget.onValueChanged(_range);
            },
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.one_to_three_months),
          leading: Radio<Range>(
            value: Range.OneToThreeMonths,
            groupValue: _range,
            onChanged: (Range? value) {
              setState(() {
                _range = value;
              });
              widget.onValueChanged(_range);
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
              widget.onValueChanged(_range);
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
              widget.onValueChanged(_range);
            },
          ),
        ),
      ],
    );
  }
}