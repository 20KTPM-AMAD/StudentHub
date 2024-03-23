import 'package:flutter/material.dart';

List<Map<String, dynamic>> list = [
  {'name': 'Nguyen Thi Ngoc Hai', 'position': 'Company', 'icon': Icons.person},
  {'name': 'Nguyen Thi Ngoc Hai', 'position': 'Student', 'icon': Icons.person}
];

const Color _green = Color(0xFF12B28C);

class DropdownUpgrade extends StatefulWidget {
  final ValueChanged<String?> onValueChanged; // Define callback function

  const DropdownUpgrade({required this.onValueChanged, Key? key})
      : super(key: key);

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
          color: _green,
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
          widget.onValueChanged(value);
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
                            const SizedBox(width: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                              child: Text(
                                value['name'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const SizedBox(width: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                value['position'],
                                style:
                                const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20.0),
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
