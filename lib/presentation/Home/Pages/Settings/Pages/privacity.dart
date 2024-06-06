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

class PrivacityScreen extends StatefulWidget {
  @override
  _PrivacityScreenState createState() => _PrivacityScreenState();
}

class _PrivacityScreenState extends State<PrivacityScreen> {
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
                              CustomTextSpanSimple(
                                textValue:
                                    "En nuestra aplicación de citas, nos tomamos muy en serio la privacidad y la seguridad de nuestros usuarios. Esta Política de Privacidad explica cómo recopilamos, utilizamos, compartimos y protegemos la información personal de nuestros usuarios. Al utilizar nuestra aplicación de citas, usted acepta expresamente los términos de esta Política de Privacidad.",
                                size: text,
                                color: AppColors.backColor,
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              CustomTextSpan(
                                  textValue: " Información que Recopilamos",
                                  size: text,
                                  color: AppColors.primaryColor,
                                  highlightedWords: []),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "1. Información de Registro: Cuando crea una cuenta en nuestra aplicación de citas, recopilamos información personal como su nombre, dirección de correo electrónico, fecha de nacimiento, género, ubicación y preferencias de búsqueda...",
                                size: text,
                                color: AppColors.backColor,
                              ),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "2. Información de Perfil: Los usuarios tienen la opción de proporcionar información adicional en sus perfiles, como fotografías, descripciones personales, intereses y preferencias de citas",
                                size: text,
                                color: AppColors.backColor,
                              ),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "3. Información de Dispositivos: Podemos recopilar información técnica sobre el dispositivo que utiliza para acceder a nuestra aplicación, como el tipo de dispositivo, el sistema operativo, la dirección IP y la identificación del dispositivo.",
                                size: text,
                                color: AppColors.backColor,
                              ),
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
