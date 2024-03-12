import 'package:flutter/material.dart';

import 'package:studenthub/components/project/pop_up_menu_project.dart';

import 'package:studenthub/pages/company_reviews_proposal/send_hire_offer_screen.dart';

const Color _green = Color(0xFF12B28C);

class AllProjectsTab extends StatefulWidget {
  const AllProjectsTab({Key? key}) : super(key: key);

  @override
  AllProjectsTabState createState() => AllProjectsTabState();
}

class AllProjectsTabState extends State<AllProjectsTab> {
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
      itemCount: 10, // Số lượng dự án trong danh sách
      itemBuilder: (context, index) {
        // Mỗi mục trong danh sách là một Card hiển thị thông tin của một dự án
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
                        AllProjectsPopupMenu.show(context);
                      },
                      icon: const Icon(Icons.pending_outlined, size: 30,),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        children: [
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            'Proposals',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          )
                        ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          '8',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        Text(
                          'Messages',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          '2',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        Text(
                          'Hired',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SendHireOfferScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
