import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/Student.dart';
import 'package:studenthub/models/User.dart';
import 'package:studenthub/pages/profile/switch_account_screen.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:studenthub/utils/student_profile_input_provider.dart';
import 'package:http/http.dart' as http;

const Color _green = Color(0xff296e48);

class ProfileInputStep3Screen extends StatefulWidget {
  const ProfileInputStep3Screen({Key? key}) : super(key: key);

  @override
  State<ProfileInputStep3Screen> createState() =>
      _ProfileInputStep3ScreenState();
}

class _ProfileInputStep3ScreenState extends State<ProfileInputStep3Screen> {
  File? cvFile;
  File? transcriptFile;

  PlatformFile? cvFileDetails;
  PlatformFile? transcriptFileDetails;

  bool isLoading = false;

  Future<void> pickFile(bool isCv) async {
    List<String> extensionType = ['doc', 'docx', 'pdf'];
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: extensionType);
      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          if (isCv) {
            cvFile = File(result.files.single.path!);
            cvFileDetails = file;
          } else {
            transcriptFile = File(result.files.single.path!);
            transcriptFileDetails = file;
          }
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> submit() async {
    try {
      setState(() {
        isLoading = true;
      });
      final techStack =
          Provider.of<StudentProfileInputProvider>(context, listen: false)
              .techStack;
      final skillSets =
          Provider.of<StudentProfileInputProvider>(context, listen: false)
              .skillSets;
      final languages =
          Provider.of<StudentProfileInputProvider>(context, listen: false)
              .languages;
      final educations =
          Provider.of<StudentProfileInputProvider>(context, listen: false)
              .educations;
      final experiences =
          Provider.of<StudentProfileInputProvider>(context, listen: false)
              .experiences;
      final token = Provider.of<AuthProvider>(context, listen: false).token;

      final response = await http.post(
        Uri.parse('http://34.16.137.128/api/profile/student'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "techStackId": techStack!.id,
          "skillSets": skillSets.map((e) => e!.id).toList(),
        }),
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        if (jsonResponse['result'] != null) {
          final student = Student.fromJson(jsonResponse['result']);
          Provider.of<AuthProvider>(context, listen: false).setStudent(student);
          final updateStudentLanguages = await http.put(
              Uri.parse(
                  'http://34.16.137.128/api/language/updateByStudentId/${student.id}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode(<String, dynamic>{
                "languages": languages,
              }));
          if (updateStudentLanguages.statusCode != 200) {
            print('Error updating student languages');
          }
          final updateStudentEducations = await http.put(
              Uri.parse(
                  'http://34.16.137.128/api/education/updateByStudentId/${student.id}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode(<String, dynamic>{
                "education": educations,
              }));
          if (updateStudentEducations.statusCode != 200) {
            print('Error updating student educations');
          }
          final updateStudentExperiences = await http.put(
              Uri.parse(
                  'http://34.16.137.128/api/experience/updateByStudentId/${student.id}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode(<String, dynamic>{
                "experience": experiences,
              }));
          if (updateStudentExperiences.statusCode != 200) {
            print('Error updating student experiences');
          }
          if (cvFile != null) {
            var request = http.MultipartRequest(
              'PUT',
              Uri.parse(
                  'http://34.16.137.128/api/profile/student/${student.id}/resume'),
            );

            request.files.add(
              http.MultipartFile(
                'file',
                cvFile!.readAsBytes().asStream(),
                cvFile!.lengthSync(),
                filename: cvFileDetails!.name,
              ),
            );

            request.headers.addAll({
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer $token',
            });

            var cvRequest = await request.send();
            if (cvRequest.statusCode != 200) {
            } else {
              print('CV file submitted');
            }
          }
          if (transcriptFile != null) {
            var request = http.MultipartRequest(
              'PUT',
              Uri.parse(
                  'http://34.16.137.128/api/profile/student/${student.id}/transcript'),
            );

            request.files.add(
              http.MultipartFile(
                'file',
                transcriptFile!.readAsBytes().asStream(),
                transcriptFile!.lengthSync(),
                filename: transcriptFileDetails!.name,
              ),
            );

            request.headers.addAll({
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer $token',
            });

            var transcriptRequest = await request.send();
            if (transcriptRequest.statusCode != 200) {
            } else {
              print('Transcript file submitted');
            }
          }
          final getProfileAgain = await http.get(
            Uri.parse('http://34.16.137.128/api/auth/me'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
          );

          if (getProfileAgain.statusCode == 200) {
            final jsonResponse = json.decode(getProfileAgain.body);
            Provider.of<AuthProvider>(context, listen: false)
                .setLoginUser(User.fromJson(jsonResponse['result']));
          }

          Provider.of<StudentProfileInputProvider>(context, listen: false)
              .clear();

          setState(() {
            cvFile = null;
            transcriptFile = null;
            cvFileDetails = null;
            transcriptFileDetails = null;
            isLoading = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SwitchAccountScreen(),
            ),
          );
        }
      }
    } catch (e) {
      print('Error submitting file: $e');
    }
  }

  @override
  void initState() {
    super.initState();
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Your Resume',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Tell us about your self and you will be on your way connect with real-world project'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'CV',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              if (cvFile == null)
                                Positioned.fill(
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 100,
                                    color: Colors
                                        .grey[300], // Adjust color as needed
                                  ),
                                ),
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(8),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: Center(
                                    child: cvFile == null
                                        ? ElevatedButton(
                                            onPressed: () => pickFile(true),
                                            child:
                                                const Text('Choose file to Up'),
                                          )
                                        : cvFileDetails != null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          cvFileDetails!.name,
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(cvFileDetails!
                                                                .extension ??
                                                            '')
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(cvFileDetails!.size
                                                        .toString())
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Transcript',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              if (transcriptFile == null)
                                Positioned.fill(
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 100,
                                    color: Colors
                                        .grey[300], // Adjust color as needed
                                  ),
                                ),
                              DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(8),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: Center(
                                    child: transcriptFile == null
                                        ? ElevatedButton(
                                            onPressed: () => pickFile(false),
                                            child:
                                                const Text('Choose file to Up'),
                                          )
                                        : transcriptFileDetails != null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          transcriptFileDetails!
                                                              .name,
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(transcriptFileDetails!
                                                                .extension ??
                                                            '')
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(transcriptFileDetails!
                                                        .size
                                                        .toString())
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await submit();
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
