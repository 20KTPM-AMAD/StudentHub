import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class OfferNotificationCard extends StatefulWidget {
  const OfferNotificationCard({Key? key}) : super(key: key);

  @override
  OfferNotificationCardState createState() => OfferNotificationCardState();
}

class OfferNotificationCardState extends State<OfferNotificationCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.settings, size: 40),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'You have offder to join project "Javis - AI Copilot"',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Số dòng tối đa
                      ),
                      const Text(
                        '6/6/2024',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              foregroundColor: Colors.black
                          ),
                          child: const Text(
                              'View offer',
                              style: TextStyle(fontSize: 16)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
