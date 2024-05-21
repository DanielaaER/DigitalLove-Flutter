import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../../shared/widgets/Gesture.dart';
import '../../../shared/widgets/TextBold.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({Key? key}) : super(key: key);

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _WifiErrorView(),
        ],
      ),
    );
  }
}

class _WifiErrorView extends StatelessWidget {
  _WifiErrorView();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(width * .2, height * .15, width * .2, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: width * .6,
              color: AppColors.accentColor,
            ),
            SizedBox(
              height: height * .05,
            ),
            CustomTextBold(
                textValue: "No hay conexión a internet",
                size: title,
                color: AppColors.accentColor),
            SizedBox(
              height: height * .03,
            ),
            Container(
              alignment: Alignment.center,
              child: CustomTextSpan(
                textValue:
                    "Por favor, verifica tu conexión y vuelve a intentarlo.",
                size: text,
                color: AppColors.backColor,
                highlightedWords: ["conexión", "vuelve", "intentarlo."],
              ),
            ),
          ],
        ));
  }
}
