import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../../shared/widgets/Gesture.dart';
import '../../../shared/widgets/TextBold.dart';
import '../../../shared/widgets/TextSpan.dart';
import '../Register.dart';

class PhotoErrorScreen extends StatefulWidget {
  const PhotoErrorScreen({Key? key}) : super(key: key);

  @override
  State<PhotoErrorScreen> createState() => _PhotoErrorScreenState();
}

class _PhotoErrorScreenState extends State<PhotoErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _PhotoErrorView(),
        ],
      ),
    );
  }
}

class _PhotoErrorView extends StatelessWidget {
  _PhotoErrorView();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Stack(alignment: Alignment.bottomCenter, children: [
      // Expanded(
      //     child:
      Container(
          alignment: Alignment.topCenter,
          height: height,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
          padding:
              EdgeInsets.fromLTRB(width * .15, height * .10, width * .15, 0),
          // padding:
          //     EdgeInsets.fromLTRB(width * .2, height * .15, width * .2, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/repeat.png',
                  fit: BoxFit.cover,
                  // height: MediaQuery.of(context).size.height * .3,
                  // width: MediaQuery.of(context).size.height * .3,
                  alignment: Alignment.topCenter,
                  // width: double.infinity,
                ),
              ),
              SizedBox(
                height: height * .2,
              ),
              CustomTextSpan(
                textValue: "Ooops! Ha ocurrido un error al tratar de capturar "
                    "la foto. Por favor reintenta tomar la fotografía",
                size: text,
                color: AppColors.backColor,
                highlightedWords: ["reintenta", "tomar", "la", "fotografía"],
              ),
            ],
          )
          // )
          ),
      Positioned(
        bottom: 90,
        child: CustomButton(
            textValue: "Reintentar",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ));
            }),
      ),
    ]);
  }
}
