import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../../shared/widgets/Gesture.dart';
import '../../../shared/widgets/TextBold.dart';

class MatchErrorScreen extends StatefulWidget {
  const MatchErrorScreen({Key? key}) : super(key: key);

  @override
  State<MatchErrorScreen> createState() => _MatchErrorScreenState();
}

class _MatchErrorScreenState extends State<MatchErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _LoginErrorView(),
    );
  }
}

class _LoginErrorView extends StatelessWidget {
  _LoginErrorView();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Expanded(
        child: Container(
            alignment: Alignment.topCenter,
            // width: width * .8,
            color: Colors.transparent,
            // color: AppColors.shadeColor.withOpacity(0.6),
            padding:
                EdgeInsets.fromLTRB(width * .2, height * .15, width * .2, 0),
            child: Column(
              children: [
                Icon(
                  Icons.heart_broken,
                  size: width * .6,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  height: height * .15,
                ),
                CustomTextBold(
                    textValue:
                        "Ooops! Parece que has superado el limite de likes por el dia de hoy, por favor intentalo mañana.",
                    size: text,
                    color: AppColors.backColor),
              ],
            )));
  }
}
