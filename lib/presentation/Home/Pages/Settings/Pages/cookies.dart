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

class CookiesScreen extends StatefulWidget {
  @override
  _CookiesScreenState createState() => _CookiesScreenState();
}

class _CookiesScreenState extends State<CookiesScreen> {
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
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: title,
                      ))),
              Padding(
                padding: EdgeInsets.only(top: height * .05, left: width * .1),
                child: CustomTextBold(
                    textValue: "Política de cookies",
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
                                  textValue: "¿Qué son las cookies?",
                                  size: text,
                                  color: AppColors.primaryColor,
                                  highlightedWords: []),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "Las cookies son pequeños archivos de texto que se almacenan en su dispositivo (ordenador, teléfono móvil o tableta) cuando visita ciertos sitios web. Estos archivos permiten que el sitio web reconozca su dispositivo y recopile información sobre su interacción con el sitio, facilitando así su experiencia de navegación y proporcionando servicios personalizados.",
                                size: text,
                                color: AppColors.backColor,
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              CustomTextSpan(
                                  textValue: "¿Comó utilizamos las cookies?",
                                  size: text,
                                  color: AppColors.primaryColor,
                                  highlightedWords: []),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "1. Cookies Esenciales: Estas cookies son esenciales para el funcionamiento de nuestra aplicación de citas. Nos permiten autenticar usuarios, garantizar la seguridad de la plataforma y proporcionar funciones básicas de navegación.",
                                size: text,
                                color: AppColors.backColor,
                              ),
                              SizedBox(
                                height: height * .01,
                              ),
                              CustomTextSpanSimple(
                                textValue:
                                    "2. Cookies de Rendimiento: Utilizamos cookies de rendimiento para recopilar información sobre cómo los usuarios interactúan con nuestra aplicación de citas, como qué páginas visitan y qué funciones utilizan con mayor frecuencia. Esta información nos ayuda a mejorar y optimizar nuestro servicio",
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
