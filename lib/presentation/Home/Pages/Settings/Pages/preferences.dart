import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:digital_love/shared/widgets/TextSpanSimple.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../../config/theme/app_colors.dart';
import '../widgets/setting.dart';

class PreferencesPrivacityScreen extends StatefulWidget {
  @override
  _PreferencesPrivacityScreenState createState() =>
      _PreferencesPrivacityScreenState();
}

class _PreferencesPrivacityScreenState
    extends State<PreferencesPrivacityScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _update(String update) {}

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var title = width * 0.07;
    var text = width * 0.05;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: AppColors.whiteColor,
          height: MediaQuery.of(context).size.height * .9,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: height * .1, left: width * .1),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: title,
                      ))),
              Padding(
                padding: EdgeInsets.only(top: height * .05, left: width * .1),
                child: CustomTextBold(
                    textValue: "Política de privacidad",
                    size: title,
                    color: AppColors.backColor),
              ),
              SizedBox(height: height * .05),
              Container(
                width: width,
                height: height * .6,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.backColor,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    bottom: BorderSide(
                      color: AppColors.backColor,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * .8,
                        // transformAlignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            top: height * .05, bottom: height * .05),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextSpan(
                                  textValue: "Cuenta privada",
                                  size: text,
                                  color: AppColors.primaryColor,
                                  highlightedWords: []),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "Si deseas volver tu cuenta privada en nuestra aplicación de citas, puedes hacerlo fácilmente . Al activar esta configuración, tu perfil y actividades relacionadas solo serán visibles para aquellos usuarios a quienes apruebes explícitamente. Esto te proporcionará un mayor control sobre quién puede ver tu información y te ayudará a mantener tu privacidad mientras disfrutas de nuestra plataforma de citas. Si necesitas ayuda adicional, no dudes en ponerte en contacto con nuestro equipo de soporte, quienes estarán encantados de ayudarte en este proceso.",
                                size: text,
                                color: AppColors.backColor,
                              ),
                              Container(
                                width: width * .5,
                                transformAlignment: Alignment.center,
                                padding: EdgeInsets.only(top: height * .05),
                                child: CustomButton(
                                  textValue: "Actualizar",
                                  onPressed: () {
                                    _update(_textController.text);
                                  },
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
