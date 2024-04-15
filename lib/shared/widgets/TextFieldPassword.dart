import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final String textValue;

  final TextEditingController controller;

  const CustomTextFieldPassword({
    required this.textValue,
    required this.controller,
  }); // C

  @override
  CustomTextFieldPasswordState createState() => CustomTextFieldPasswordState();
}

class CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool showText = true;


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    bool _obscureText = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.textValue,
          style: TextStyle(
            fontSize: text,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 0.05,
        ),
        TextField(
          controller: widget.controller,
          obscureText: showText,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
            hintText: 'Ingresa tu ${widget.textValue}',
            hintStyle: TextStyle(
                color: AppColors.shadeColor, //
                fontWeight: FontWeight.normal,
                fontSize: text * 0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: AppColors.backColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accentColor),
              borderRadius: BorderRadius.circular(15.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                showText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.accentColor,
              ),
              onPressed: () {
                setState(() {
                  showText = !showText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
