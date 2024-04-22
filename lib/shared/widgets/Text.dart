import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomText extends StatelessWidget {
  final String textValue;
  final double size;
  final Color color;

  const CustomText({
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
        fontWeight: FontWeight.normal,
      ),
      // textAlign: TextAlign.justify,
    );
  }
}
