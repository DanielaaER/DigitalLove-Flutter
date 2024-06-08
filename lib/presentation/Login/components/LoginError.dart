import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../../shared/widgets/Gesture.dart';
import '../../../shared/widgets/TextBold.dart';

class LoginErrorScreen extends StatefulWidget {
  const LoginErrorScreen({Key? key}) : super(key: key);

  @override
  State<LoginErrorScreen> createState() => _LoginErrorScreenState();
}

class _LoginErrorScreenState extends State<LoginErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _LoginErrorView(),
        ],
      ),
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
    return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(width * .2, height * .15, width * .2, 0),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: width * .6,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: height * .15,
            ),
            CustomTextBold(
                textValue:
                    "Ooops! Parece que ha habido un error al iniciar sesión, por favor verifica tus credenciales o intentalo más tarde.",
                size: text,
                color: AppColors.backColor),
            SizedBox(
              height: height * .15,
            ),
            CustomButton(
                textValue: "Reintentar",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                })
          ],
        ));
  }
}
