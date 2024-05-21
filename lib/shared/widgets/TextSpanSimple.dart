import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextSpanSimple extends StatelessWidget {
  final String textValue;
  final double size;
  final Color color;

  const CustomTextSpanSimple({
    required this.textValue,
    required this.size,
    required this.color,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildTextSpan(),
    );
  }

  TextSpan _buildTextSpan() {
    final defaultStyle = TextStyle(
      fontSize: size * .7,
      color: color,
      fontWeight: FontWeight.normal,
    );

    List<TextSpan> textSpans = [];

    for (var word in textValue.split(' ')) {
      textSpans.add(
        TextSpan(
          text: '$word ',
          style: defaultStyle,
        ),
      );
    }

    return TextSpan(children: textSpans, style: defaultStyle);
  }
}
