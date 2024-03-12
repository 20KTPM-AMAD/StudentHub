import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({Key? key}) : super(key: key);

  @override
  ProjectDetailState createState() => ProjectDetailState();
}

class ProjectDetailState extends State<ProjectDetailScreen>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    const Text(
                      'Project detail',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Senior frontend developer (Fintech)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _green,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Divider(),
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
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm_outlined, size: 40,),
                        SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Project scope',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(
                              '3 to 6 month',
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.group_outlined, size: 40,),
                        SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Student required',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(
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
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Apply Now', style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _green,
                          foregroundColor: Colors.black
                      ),
                      child: const Text('Saved', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}