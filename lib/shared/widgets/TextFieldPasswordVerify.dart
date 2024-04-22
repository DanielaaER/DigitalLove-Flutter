import 'package:digital_love/shared/widgets/Text.dart';
import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class CustomTextFieldPasswordVerify extends StatefulWidget {
  final String textValue;

  final TextEditingController controller;

  const CustomTextFieldPasswordVerify({
    required this.textValue,
    required this.controller,
  }); // C

  @override
  CustomTextFieldPasswordVerifyState createState() =>
      CustomTextFieldPasswordVerifyState();
}

class CustomTextFieldPasswordVerifyState
    extends State<CustomTextFieldPasswordVerify> {
  bool showText = true;
  Color caracters = AppColors.greyColor;
  Color capitalLetter = AppColors.greyColor;
  Color symbol = AppColors.greyColor;
  // bool isPasswordValid = false;

  void _checkPassword(String password) {
    setState(() {
      caracters =
          password.length >= 8 ? AppColors.primaryColor : AppColors.greyColor;
      capitalLetter = RegExp(r'[A-Z]').hasMatch(password)
          ? AppColors.primaryColor
          : AppColors.greyColor;
      symbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)
          ? AppColors.primaryColor
          : AppColors.greyColor;
      // isPasswordValid = password.length >= 8 &&
      //     RegExp(r'[A-Z]').hasMatch(password) &&
      //     RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

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
          onChanged: _checkPassword,
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
        Container(
          padding: EdgeInsets.fromLTRB(width * .02, height * 0.002, 0, 0),
          alignment: Alignment.topLeft,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(),
                    Column(
                      children: [],
                    ),
                  ],
                ),
                CustomText(
                    textValue: " • Debe tener un minimo de 8 caracteres",
                    size: text * .75,
                    color: caracters),
                CustomText(
                  textValue:
                      " • Debe incluir al menos una letra mayúscula y una   minúscula",
                  size: text * .75,
                  color: capitalLetter,
                ),
                CustomText(
                  textValue:
                      ' • Debe incluir al menos un símbolo (por ejemplo, !, @, \$,  %',
                  size: text * .75,
                  color: symbol,
                )
              ]),
        ),
      ],
    );
  }
}
