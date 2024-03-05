import 'package:flutter/material.dart';

class InputGroup extends StatelessWidget {
  const InputGroup({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter $name',
              ),
            ),
          ],
        ),
      ),
    );
  }
}