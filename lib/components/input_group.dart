import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class InputGroup extends StatelessWidget {

  InputGroup({
    Key? key,
    required this.name,
    String? hint,
  })  : hint = hint ?? 'Enter $name',
        super(key: key);

  @override

  final String name;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: _green),
                ),
                hintText: "Enter $name",
                hintStyle: TextStyle(color: _green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}