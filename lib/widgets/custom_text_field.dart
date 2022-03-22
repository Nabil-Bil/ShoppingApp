import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLength: maxLength,
        maxLines: 1,
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
        ),
        keyboardType: keyboardType);
  }
}
