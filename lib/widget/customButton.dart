import 'package:flutter/material.dart';

class Custombuttons extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  const Custombuttons({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: const Size(60, 60),
          // shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
