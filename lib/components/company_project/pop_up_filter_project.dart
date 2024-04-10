import 'package:flutter/material.dart';
import 'package:studenthub/components/input_group.dart';
import 'package:studenthub/components/company_project/radio_button_group_project_length.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class ProjectPopupFilter {
  static Future<Map<String, dynamic>?> show(BuildContext context) async {
    TextEditingController studentsController = TextEditingController();
    TextEditingController proposalsController = TextEditingController();
    Range? selectedRange;

    String mapRangeToString(Range? range) {
      switch (range) {
        case Range.LessThanOneMonth:
          return '0';
        case Range.OneToThreeMonths:
          return '1';
        case Range.ThreeToSixMonths:
          return '2';
        case Range.MoreThanSixMonths:
          return '3';
        default:
          return '';
      }
    }

    return await showModalBottomSheet<Map<String, dynamic>>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Text(
                        AppLocalizations.of(context)!.filter_by,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Text(
                        AppLocalizations.of(context)!.project_length,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RadioButtonGroupProjectLength(
                      onValueChanged: (value) {
                        setState(() {
                          selectedRange = value;
                        });
                      },
                    ),
                    InputGroup(
                      name: AppLocalizations.of(context)!.students_needed,
                      controller: studentsController,
                    ),
                    InputGroup(
                      name: AppLocalizations.of(context)!.proposals_less_than,
                      controller: proposalsController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                studentsController.clear();
                                proposalsController.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.black,
                            ),
                            child: Text(AppLocalizations.of(context)!.clear_filters, style: const TextStyle(fontSize: 18)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              String studentsValue = studentsController.text;
                              String proposalsValue = proposalsController.text;
                              String rangeValue = mapRangeToString(selectedRange);

                              Navigator.pop(
                                context,
                                {
                                  'students': studentsValue,
                                  'proposals': proposalsValue,
                                  'range': rangeValue,
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _green,
                                foregroundColor: Colors.black
                            ),
                            child: Text(AppLocalizations.of(context)!.apply, style: const TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
