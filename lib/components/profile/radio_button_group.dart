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
  final TextEditingController controller;

  const RadioButtonGroup({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RadioButtonGroup> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  Range? _range;

  @override
  void initState() {
    super.initState();
    // Gán giá trị ban đầu của controller dựa trên giá trị mặc định của _range
    widget.controller.text = ''; // Không có giá trị mặc định
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRadioListTile(Range.ItIsJustMe),
        _buildRadioListTile(Range.TwoToNineEmployees),
        _buildRadioListTile(Range.TenToNinetyNineEmployees),
        _buildRadioListTile(Range.HundredToOneThousandEmployees),
        _buildRadioListTile(Range.MoreThanOneThousandEmployees),
      ],
    );
  }

  ListTile _buildRadioListTile(Range range) {
    return ListTile(
      title: Text(_getRangeText(context, range)),
      leading: Radio<Range>(
        value: range,
        groupValue: _range,
        onChanged: (Range? value) {
          setState(() {
            _range = value;
            widget.controller.text = _getRangeValue(value).toString();
          });
        },
      ),
    );
  }

  String _getRangeText(BuildContext context, Range range) {
    switch (range) {
      case Range.ItIsJustMe:
        return AppLocalizations.of(context)!.its_just_me;
      case Range.TwoToNineEmployees:
        return AppLocalizations.of(context)!.two_nine_employees;
      case Range.TenToNinetyNineEmployees:
        return AppLocalizations.of(context)!.ten_ninetynine_employees;
      case Range.HundredToOneThousandEmployees:
        return AppLocalizations.of(context)!.hundred_thousand_employees;
      case Range.MoreThanOneThousandEmployees:
        return AppLocalizations.of(context)!.more_than_thousand_employees;
      default:
        return '';
    }
  }

  int _getRangeValue(Range? range) {
    switch (range) {
      case Range.ItIsJustMe:
        return 0;
      case Range.TwoToNineEmployees:
        return 1;
      case Range.TenToNinetyNineEmployees:
        return 2;
      case Range.HundredToOneThousandEmployees:
        return 3;
      case Range.MoreThanOneThousandEmployees:
        return 4;
      default:
        return 0;
    }
  }
}
