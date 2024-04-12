import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Company.dart';
import 'package:studenthub/models/User.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/components/profile/radio_button_group.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rangeController = TextEditingController();

  late final User? loginUser;
  @override
  void initState() {
    super.initState();
    loginUser = Provider.of<AuthProvider>(context, listen: false).loginUser;
    companyNameController.text = loginUser!.company!.companyName;
    websiteController.text = loginUser!.company!.website;
    descriptionController.text = loginUser!.company!.description;
    rangeController.text = loginUser!.company!.size.toString(); // Convert số thành chuỗi
  }

  Future<void> updateProfileCompany() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final companyId = loginUser!.company!.id;

    final response = await http.put(
      Uri.parse('http://34.16.137.128/api/profile/company/$companyId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'companyName': companyNameController.text,
        'website': websiteController.text,
        'description': descriptionController.text
      }),
    );

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (jsonResponse['result'] != null) {
        final company = Company.fromJson(jsonResponse['result']);
        Provider.of<AuthProvider>(context, listen: false).setCompany(company);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.welcome_to_studenthub,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.company_name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: companyNameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: _green),
                                ),
                                hintText: AppLocalizations.of(context)!.enter_company_name,
                                hintStyle: const TextStyle(color: _green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.website,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: websiteController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: _green),
                                ),
                                hintText: AppLocalizations.of(context)!.enter_web_site,
                                hintStyle: const TextStyle(color: _green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.description,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextField(
                              controller: descriptionController,
                              maxLines: 6, //or null
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: _green),
                                ),
                                hintText: AppLocalizations.of(context)!.hint_description,
                                hintStyle: const TextStyle(color: _green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.how_many_people_company,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                _getRangeText(Range.values[int.parse(rangeController.text)]),
                              ),
                              leading: Radio<Range>(
                                value: Range.values[int.parse(rangeController.text)],
                                groupValue: Range.values[int.parse(rangeController.text)],
                                onChanged: (Range? value) {
                                  setState(() {
                                    rangeController.text = value!.index.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        updateProfileCompany();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: _green,
                        fixedSize: const Size(120, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey[300],
                        fixedSize: const Size(120, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(),
      ),
    );
  }

  String _getRangeText(Range range) {
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
}