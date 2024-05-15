import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/components/authentication/custom_textfield.dart';
import 'package:studenthub/components/profile/radio_button_group.dart';
import 'package:studenthub/main_screen.dart';
import 'package:studenthub/models/Company.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class ProfileInputScreen extends StatefulWidget {
  const ProfileInputScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInputScreen> createState() => _ProfileInputScreenState();
}

class _ProfileInputScreenState extends State<ProfileInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rangeController = TextEditingController();

  @override
  void initState() {}

  Future<void> createProfileCompany() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.post(
      Uri.parse('http://34.16.137.128/api/profile/company'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'companyName': companyNameController.text,
        'size': int.parse(rangeController.text),
        'website': websiteController.text,
        'description': descriptionController.text
      }),
    );

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      if (jsonResponse['result'] != null) {
        final company = Company.fromJson(jsonResponse['result']);
        Provider.of<AuthProvider>(context, listen: false).setCompany(company);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.welcome_to_studenthub,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.intro_six,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    const SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.how_many_people_company,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    RadioButtonGroup(
                      controller: rangeController,
                    ),
                    CustomTextfield(
                      title: AppLocalizations.of(context)!.company_name,
                      controller: companyNameController,
                      obscureText: false,
                      hintText:
                          AppLocalizations.of(context)!.enter_company_name,
                      icon: Icons.account_box_outlined,
                      required: true,
                    ),
                    CustomTextfield(
                      title: AppLocalizations.of(context)!.website,
                      controller: websiteController,
                      obscureText: false,
                      hintText: AppLocalizations.of(context)!.enter_website,
                      icon: Icons.connect_without_contact,
                      required: true,
                    ),
                    CustomTextfield(
                      title: AppLocalizations.of(context)!.description,
                      controller: descriptionController,
                      obscureText: false,
                      hintText: AppLocalizations.of(context)!.enter_description,
                      icon: Icons.description,
                      required: true,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (rangeController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select an option'),
                                  ),
                                );
                              } else {
                                // create profile company
                                createProfileCompany();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              foregroundColor: Colors.white),
                          child: Text(AppLocalizations.of(context)!.continue_,
                              style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }
}
