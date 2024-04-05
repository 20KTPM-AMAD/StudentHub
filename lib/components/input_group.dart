import 'package:flutter/material.dart';

const Color _green = Color(0xFF12B28C);

class InputGroup extends StatelessWidget {

  const InputGroup({
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: _green),
                ),
                hintText: "Enter $name",
                hintStyle: const TextStyle(color: _green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}