import 'package:flutter/material.dart';

import 'package:studenthub/components/tab_detail.dart';
import '../../components/tab_proposals.dart';

const Color _green = Color(0xFF12B28C);

class SendHireOfferScreen extends StatefulWidget{
  const SendHireOfferScreen({Key? key}) : super(key: key);

  @override
  SendHireOfferState createState() => SendHireOfferState();
}

class SendHireOfferState extends State<SendHireOfferScreen>{
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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Senior frontend developer (Fintech)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: _green,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  DefaultTabController(
                      length: 4,
                      child: Column(
                        children: [
                          const TabBar(
                              tabs: [
                                Tab(text: 'Proposals'),
                                Tab(text: 'Detail'),
                                Tab(text: 'Message'),
                                Tab(text: 'Hired'),
                              ]
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - kToolbarHeight - 200, // Giảm đi kích thước của AppBar và khoảng cách dưới cùng
                            child: const TabBarView(
                              children: [
                                ProposalsTab(),
                                DetailTab(),
                                Center(
                                  child: Text('Message Content'),
                                ),
                                Center(
                                  child: Text('Hired Content'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}