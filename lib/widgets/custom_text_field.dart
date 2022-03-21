import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField(
      {Key? key,
      required this.title,
      required this.controller,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
        ),
        keyboardType: keyboardType);
  }
}
