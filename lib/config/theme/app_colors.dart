import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xffF6F6F6);
  static const Color primaryColor = Color(0xffA771F0);
  static const Color accentColor = Color(0xff7D53B6);
  static const Color secondaryColor = Color(0xffb384f3);
  static const Color complementaryColor = Color(0xffDE6830);
  static const Color errorColor = Color(0xffFF7171);
  static const Color shadeColor = Color(0xff6C6D6D);
  static const Color greyColor = Color(0xff9c9f9f);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color backColor = Color(0xff27262C);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: whiteColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.black87),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.white),
    ),
  );
}