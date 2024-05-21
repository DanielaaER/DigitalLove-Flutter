import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  final String setting;
  final VoidCallback? onPressed;

  SettingWidget({required this.setting, this.onPressed});



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var title = width * 0.05;
    var text = width * 0.04;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * .005, horizontal: width * .05),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.backColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextBold(
                size: title * .8,
                color: AppColors.backColor,
                textValue: setting,
              ),
              CustomTextBold(
                size: title,
                color: AppColors.backColor,
                textValue: ">",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
