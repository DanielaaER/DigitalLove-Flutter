import 'package:digital_love/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LabelItem extends StatelessWidget {
  final int index;

  LabelItem(this.index);

  @override
  Widget build(BuildContext context) {
    var text = index.toString();
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    var width = MediaQuery.of(context).size.width;

    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.zero,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(45),
        ),
        side: BorderSide(color: Colors.transparent, width: 0),
      ),
      backgroundColor: AppColors.primaryColor,
      label: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: width * .090),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
