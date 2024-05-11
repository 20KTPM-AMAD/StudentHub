import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub/models/Project.dart';
import 'package:studenthub/pages/browse_project/post_project_step_3.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xff296e48);

enum Range {
  LessThanOneMonth,
  OneToThreeMonths,
  ThreeToSixMonths,
  MoreThanSixMonths
}

class PostProjectStep2Screen extends StatefulWidget {
  PostProjectStep2Screen({Key? key, required this.title, this.project})
      : super(key: key);

  final String title;
  final Project? project;

  @override
  PostProjectStep2State createState() => PostProjectStep2State();
}

class PostProjectStep2State extends State<PostProjectStep2Screen> {
  Range _range = Range.LessThanOneMonth;

  TextEditingController projectScopeController = TextEditingController();
  TextEditingController numberOfStudentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _range = _mapValueToRange(widget.project!.projectScopeFlag);
      projectScopeController.text = widget.project!.projectScopeFlag.toString();
      numberOfStudentController.text =
          widget.project!.numberOfStudents.toString();
    }
    projectScopeController.text = mapRangeToValue(_range);
  }

  Range _mapValueToRange(int value) {
    switch (value) {
      case 0:
        return Range.LessThanOneMonth;
      case 1:
        return Range.OneToThreeMonths;
      case 2:
        return Range.ThreeToSixMonths;
      case 3:
        return Range.MoreThanSixMonths;
      default:
        return Range.LessThanOneMonth; // Giá trị mặc định nếu không trùng khớp
    }
  }

  String mapRangeToValue(Range range) {
    switch (range) {
      case Range.LessThanOneMonth:
        return '0';
      case Range.OneToThreeMonths:
        return '1';
      case Range.ThreeToSixMonths:
        return '2';
      case Range.MoreThanSixMonths:
        return '3';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('StudentHub'),
          backgroundColor: _green,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      '2/4',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.estimate_scope,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.size_timeline,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.how_long,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.less_than_one_month,
                          ),
                          leading: Radio<Range>(
                            value: Range.LessThanOneMonth,
                            groupValue: _range,
                            onChanged: (Range? value) {
                              setState(() {
                                _range = value!;
                                projectScopeController.text =
                                    mapRangeToValue(_range);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.one_to_three_months,
                          ),
                          leading: Radio<Range>(
                            value: Range.OneToThreeMonths,
                            groupValue: _range,
                            onChanged: (Range? value) {
                              setState(() {
                                _range = value!;
                                projectScopeController.text =
                                    mapRangeToValue(_range);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.three_to_six_months,
                          ),
                          leading: Radio<Range>(
                            value: Range.ThreeToSixMonths,
                            groupValue: _range,
                            onChanged: (Range? value) {
                              setState(() {
                                _range = value!;
                                projectScopeController.text =
                                    mapRangeToValue(_range);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.more_than_six_months,
                          ),
                          leading: Radio<Range>(
                            value: Range.MoreThanSixMonths,
                            groupValue: _range,
                            onChanged: (Range? value) {
                              setState(() {
                                _range = value!;
                                projectScopeController.text =
                                    mapRangeToValue(_range);
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.how_many_students,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: numberOfStudentController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: _green),
                        ),
                        hintText:
                            AppLocalizations.of(context)!.number_of_students,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                                  .number_of_students +
                              'is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostProjectStep3Screen(
                                  title: widget.title,
                                  projectScopeFlag: projectScopeController.text,
                                  numberOfStudents:
                                      numberOfStudentController.text,
                                  project: widget.project)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                          AppLocalizations.of(context)!.next_description,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                )
              ])),
        ));
  }
}
