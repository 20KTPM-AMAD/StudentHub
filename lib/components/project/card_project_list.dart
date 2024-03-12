import 'package:flutter/material.dart';
import 'package:studenthub/pages/browse_project/project_detail_screen.dart';

const Color _green = Color(0xFF12B28C);

class ProjectListTab extends StatefulWidget {
  const ProjectListTab({Key? key}) : super(key: key);

  @override
  ProjectListTabState createState() => ProjectListTabState();
}

class ProjectListTabState extends State<ProjectListTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Senior frontend developer (Fintech)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _green,
                        ),
                        overflow: TextOverflow.ellipsis, // Hiển thị dấu ... khi văn bản tràn ra ngoài
                      ),
                    ),
                    const SizedBox(width: 10,),
                    IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(Icons.favorite_border_outlined, size: 30,),
                    ),
                  ],
                ),

                const Text(
                  'Created 3 days ago',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'Time: 1-3 months, 6 students needed',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Students are looking for:\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '- Clear expectation about your project or deliverables',
                        style: TextStyle(
                          fontSize: 16, // Cỡ chữ
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Proposals: Less than 5',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProjectDetailScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
