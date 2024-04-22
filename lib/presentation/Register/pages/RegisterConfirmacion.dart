import 'package:digital_love/presentation/Register/pages/CredentialConfirmacion.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../../shared/widgets/Gesture.dart';
import '../../../shared/widgets/TextBold.dart';
import '../../../shared/widgets/TextSpan.dart';

class RegisterConfirmationScreen extends StatefulWidget {
  const RegisterConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterConfirmationScreen> createState() =>
      _RegisterConfirmationScreenState();
}

class _RegisterConfirmationScreenState
    extends State<RegisterConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _RegisterConfirmationView(),
        ],
      ),
    );
  }
}

class _RegisterConfirmationView extends StatelessWidget {
  _RegisterConfirmationView();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
          alignment: Alignment.topCenter,
          height: height * .9,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
          padding:
              EdgeInsets.fromLTRB(width * .15, height * .10, width * .15, 0),
          // padding:
          //     EdgeInsets.fromLTRB(width * .2, height * .15, width * .2, 0),
          child: Column(
            children: [
              CustomTextSpan(
                textValue:
                    "¡Excelente! Estas un paso más  cerca de finalizar el "
                    "registro. Ahora tomate una foto para confirmar tu "
                    "identidad",
                size: text,
                color: AppColors.backColor,
                highlightedWords: ["confirmar", "tu", "identidad"],
              ),
              SizedBox(
                height: height * .10,
              ),
              CustomText(
                  textValue:
                      "Ten a la mano tu identificación oficial vigente y "
                      "procura tomar la foto en un ambiente bien iluminado.",
                  size: text,
                  color: AppColors.backColor),
              SizedBox(
                height: height * .05,
              ),
              CustomText(
                  textValue:
                      "Para que la foto tenga más probabilidades de ser aceptada se recomienda:",
                  size: text,
                  color: AppColors.backColor),
              SizedBox(
                height: height * .04,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        textValue: " - Tomarla desde buen angulo.",
                        size: text,
                        color: AppColors.accentColor),
                    CustomText(
                        textValue: " - Limpiar el lente de la cámara",
                        size: text,
                        color: AppColors.accentColor),
                    CustomText(
                        textValue: " - Evitar el desenfoque",
                        size: text,
                        color: AppColors.accentColor),
                  ],
                ),
              ),
            ],
          )),
      Positioned(
        bottom: 20,
        child: CustomButton(
            textValue: "Siguiente",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CredentialConfirmationScreen(),
                  ));
            }),
      ),
    ]);
  }
}
