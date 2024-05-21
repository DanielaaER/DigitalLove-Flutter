import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextBold extends StatelessWidget {
  final String textValue;
  final double size;
  final Color color;

  const CustomTextBold({
    required this.textValue,
    required this.size,
    required this.color,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      // textAlign: TextAlign.justify,
    );
  }
}
