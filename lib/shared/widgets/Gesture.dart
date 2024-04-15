import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomGesture extends StatelessWidget {
  final String textValue;
  final VoidCallback? onPressed;

  const CustomGesture({
    required this.textValue,
    this.onPressed,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var text = width * 0.04;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            textValue,
            style: TextStyle(
                fontSize: text,
                color: AppColors.accentColor,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}
