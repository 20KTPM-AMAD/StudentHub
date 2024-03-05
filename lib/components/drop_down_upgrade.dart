import 'package:flutter/material.dart';

List<Map<String, dynamic>> list = [
  {'name': 'Nguyen Thi Ngoc Hai', 'position': 'Company', 'icon': Icons.person},
  {
    'name': 'Nguyen Thi Ngoc Hai',
    'position': 'Student',
    'icon': Icons.person
  }
];

class DropdownUpgrade extends StatefulWidget {
  const DropdownUpgrade({super.key});

  @override
  State<DropdownUpgrade> createState() => _DropdownUpgradeState();
}

class _DropdownUpgradeState extends State<DropdownUpgrade> {
  var dropdownValue = list.first['position'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.green,
          width: 2.0,
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_up),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
          return DropdownMenuItem<String>(
            value: value['position'],
            child: Container(
                width: 340, // Set the width as desired
                height: 350, // Set the height as desired
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Icon(value['icon'], size: 50.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 8.0),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0, top: 5.0),
                              child: Text(
                                value['name'],
                                style: TextStyle(fontSize: 20, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            SizedBox(width: 8.0),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                value['position'],
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),
                  ],
                )),
          );
        }).toList(),
      ),
    );
  }
}
