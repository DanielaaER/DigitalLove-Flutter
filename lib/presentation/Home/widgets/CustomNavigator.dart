import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<IconData> iconList;

  // final List<String> labelList;
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.iconList,
    // required this.labelList,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    // Configura la altura deseada aquí
    final double barHeight = height * 0.07;
    final double barWidtht = width * 0.7;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      child: Container(
        height: barHeight,
        width: barWidtht,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(iconList.length, (index) {
            final color = index == currentIndex
                ? AppColors.yellowColor
                : AppColors.whiteColor;

            return GestureDetector(
              onTap: () => onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconList[index],
                    size: height * .03,
                    color: color,
                  ),
                  // ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
