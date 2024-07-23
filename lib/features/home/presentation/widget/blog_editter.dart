import 'package:flutter/material.dart';

class BlogEditter extends StatelessWidget {
  const BlogEditter(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing!';
        }
      },
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
    );
  }
}
