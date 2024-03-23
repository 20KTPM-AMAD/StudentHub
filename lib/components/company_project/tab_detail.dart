import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);

class DetailTab extends StatefulWidget {
  const DetailTab({Key? key}) : super(key: key);

  @override
  DetailTabState createState() => DetailTabState();
}

class DetailTabState extends State<DetailTab>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Students are looking for:\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(height: 30), // Khoảng cách giữa các dòng
                          ),
                          TextSpan(
                            text: '- Clear expectation about your project or deliverables\n'
                                '- The skills required for your project\n'
                                '- Detail about your project\n',
                            style: TextStyle(
                              fontSize: 20, // Cỡ chữ
                              height: 1.5, // Khoảng cách giữa các dòng
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 3),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.alarm_outlined, size: 40,),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.project_scope,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.three_to_six_months,
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.group_outlined, size: 40,),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.student_required,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            const Text(
                              '6 students',
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  foregroundColor: Colors.black
              ),
              child: Text(AppLocalizations.of(context)!.post_job, style: const TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );

  }
}