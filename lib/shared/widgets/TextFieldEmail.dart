import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextFieldEmail extends StatefulWidget {
  final String textValue;
  final TextEditingController controller;

  const CustomTextFieldEmail({
    required this.textValue,
    required this.controller,
  });

  @override
  _CustomTextFieldEmailState createState() => _CustomTextFieldEmailState();
}

class _CustomTextFieldEmailState extends State<CustomTextFieldEmail> {
  bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var text = width * 0.05;

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
        SizedBox(height: 0.05),
        TextField(
          controller: widget.controller,
          onChanged: (value) {
            setState(() {
              _isEmailValid = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value);
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
            hintText: 'Ingresa tu ${widget.textValue}',
            hintStyle: TextStyle(
              color: AppColors.shadeColor,
              fontWeight: FontWeight.normal,
              fontSize: text * 0.8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: AppColors.backColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accentColor),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorText: _isEmailValid
                ? null
                : 'Por favor, ingresa un correo electrónico válido',
          ),
        ),
      ],
    );
  }
}
