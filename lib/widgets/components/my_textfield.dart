import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  const MyTextField({super.key, 
    // super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  });
  final controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 56, 67, 77),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 95, 168, 228),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
