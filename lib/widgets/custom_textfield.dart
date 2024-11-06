import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ]
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: bgColor,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}