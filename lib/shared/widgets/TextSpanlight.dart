import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextSpanLight extends StatelessWidget {
  final String textValue;
  final double size;
  final Color color;
  final List<String> highlightedWords;

  const CustomTextSpanLight({
    required this.textValue,
    required this.size,
    required this.color,
    required this.highlightedWords,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildTextSpan(),
    );
  }

  TextSpan _buildTextSpan() {
    final defaultStyle = TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.normal,
    );

    final highlightedStyle = TextStyle(
      fontSize: size,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    );

    List<TextSpan> textSpans = [];

    for (var word in textValue.split(' ')) {
      if (highlightedWords.contains(word)) {
        textSpans.add(
          TextSpan(
            text: '$word ',
            style: highlightedStyle,
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: '$word ',
            style: defaultStyle,
          ),
        );
      }
    }

    return TextSpan(
      children: textSpans,
    );
  }
}
