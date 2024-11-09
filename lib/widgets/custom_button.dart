import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String text;
  const CustomButton({Key? key, required this.onPressed, required this.text,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            spreadRadius: 0
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width/3, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Adjust this value for less/more rounded corners
          ),
          backgroundColor: Color.fromRGBO(238, 217, 179, 1)
        ),
        child: Text(text, style: const TextStyle(fontSize: 15, color: Color.fromRGBO(163, 76, 80, 1))),
        ),
    );
  }
}