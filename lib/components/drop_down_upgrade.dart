import 'package:flutter/material.dart';

const Color _green = Color(0xff296e48);

class DropdownUpgrade extends StatefulWidget {
  final ValueChanged<String?> onValueChanged; // Define callback function
  final List<Map<String, dynamic>> list;
  final String value;

  const DropdownUpgrade(
      {required this.onValueChanged,
      required this.list,
      Key? key,
      required this.value})
      : super(key: key);

  @override
  State<DropdownUpgrade> createState() => _DropdownUpgradeState();
}

class _DropdownUpgradeState extends State<DropdownUpgrade> {
  @override
  Widget build(BuildContext context) {
    var dropdownValue = widget.value;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_up),
        elevation: 16,
        style: const TextStyle(color: Colors.green),
        underline: Container(
          height: 0,
        ),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
          widget.onValueChanged(value);
        },
        items: widget.list
            .map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
          return DropdownMenuItem<String>(
            value: value['position'],
            child: Container(
                width: 320,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      value['icon'],
                      size: 50.0,
                      color: Colors.black,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 8.0),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 5.0),
                              child: Text(
                                value['name'],
                                style: const TextStyle(fontSize: 20),
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
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
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
