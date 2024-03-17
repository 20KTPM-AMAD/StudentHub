import 'package:flutter/material.dart';

import 'package:studenthub/components/student_project/student_project_detail_card.dart';

const Color _green = Color(0xFF12B28C);

class StudentAllProjectsTab extends StatefulWidget {
  const StudentAllProjectsTab({Key? key}) : super(key: key);

  @override
  StudentAllProjectsTabState createState() => StudentAllProjectsTabState();
}

class StudentAllProjectsTabState extends State<StudentAllProjectsTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: _green, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Active proposal (0)',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const StudentProjectDetailCard();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: _green, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Submitted proposal (0)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const StudentProjectDetailCard();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
