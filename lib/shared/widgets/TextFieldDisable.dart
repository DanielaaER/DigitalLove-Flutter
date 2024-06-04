import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextFieldDisable extends StatelessWidget {
  final String titleValue;
  final String textValue;


  const CustomTextFieldDisable({
    required this.textValue, required this.titleValue,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          titleValue,
          style: TextStyle(
            fontSize: text,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 0.05,),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(width * .05, 0, 10, width * .05),
            hintText: '$textValue',
            hintStyle: TextStyle(
                color: AppColors
                    .shadeColor, //
                fontWeight: FontWeight.normal,
                fontSize: text * 0.8
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: AppColors.backColor),

            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accentColor),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),

        ),
      ],
    );
  }
}