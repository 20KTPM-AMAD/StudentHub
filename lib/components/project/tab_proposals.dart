import 'package:flutter/material.dart';

import 'notification_send_hire_offer.dart';

const Color _green = Color(0xFF12B28C);

class ProposalsTab extends StatefulWidget {
  const ProposalsTab({Key? key}) : super(key: key);

  @override
  ProposalsTabState createState() => ProposalsTabState();
}

class ProposalsTabState extends State<ProposalsTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Chỉ sử dụng không gian cần thiết
      physics: const ScrollPhysics(), // Không cho phép cuộn
      itemCount: 10, // Số lượng dự án trong danh sách
      itemBuilder: (context, index) {
        // Mỗi mục trong danh sách là một Card hiển thị thông tin của một dự án
        return Card(
          margin: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.person_4,
                      size: 100,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hung Le',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _green,
                            ),
                            overflow: TextOverflow.ellipsis, // Hiển thị dấu ... khi văn bản tràn ra ngoài
                          ),
                          Text(
                            '4th year student',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Fullstack Engineer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                      'Excellent',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'I have gone through your project and it seem like a great project. I will commit for your project...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.black,
                            fixedSize: const Size(130, 40),
                        ),
                        child: const Text('Message', style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                      onPressed:() {
                        SendHireOfferDialog.showMyDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.black,
                        fixedSize: const Size(130, 40),
                      ),
                      child: const Text(
                          'Send hired offer',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
