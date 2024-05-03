import 'package:flutter/material.dart';

var primaryColor = const Color(0xff296e48);

class CustomTextfield extends StatefulWidget {
  final IconData icon;
  final bool obscureText;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool required;

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.title,
    required this.hintText,
    required this.controller,
    bool? required,
  })  : required = required ?? false,
        super(key: key);

  @override
  CustomTextfieldState createState() => CustomTextfieldState();
}


class CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText && _obscureText,
          style: const TextStyle(color: Colors.black54),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.black54.withOpacity(.3),
            ),
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(_obscureText
                    ? Icons.visibility
                    : Icons.visibility_off),
            )
                : null,
          ),
          cursorColor: Colors.black54.withOpacity(.5),
          validator: (value) {
            if (widget.required && (value == null || value.isEmpty)) {
              return '${widget.title} is required';
            }
            return null;
          },
          onChanged: (value) {
            if (widget.required && (value == null || value.isEmpty)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.title} is required'),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
