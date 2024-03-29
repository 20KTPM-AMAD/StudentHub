import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  CustomTextfieldState createState() => CustomTextfieldState();
}

class CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText && _obscureText,
      style: const TextStyle(
        color: Colors.black54,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(widget.icon, color: Colors.black54.withOpacity(.3)),
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        )
            : null,
      ),
      cursorColor: Colors.black54.withOpacity(.5),
    );
  }
}
