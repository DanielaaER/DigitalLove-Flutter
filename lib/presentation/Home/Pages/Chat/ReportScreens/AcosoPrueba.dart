import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_colors.dart';

class AcosoScreen extends StatefulWidget {
  @override
  _AcosoScreenState createState() => _AcosoScreenState();
}

class _AcosoScreenState extends State<AcosoScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _update(String update) {
    TextEditingController _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var title = width * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: AppColors.whiteColor,
        height: MediaQuery.of(context).size.height * .8,
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
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * .05, left: width * .1),
              child: CustomTextBold(
                textValue: "Reportar",
                size: title,
                color: AppColors.backColor,
              ),
            ),
            SizedBox(height: height * .05),
            Container(
              width: width,
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
              child: Column(
                children: [
                  Container(
                    width: width * .8,
                    transformAlignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      top: height * .05,
                      bottom: height * .05,
                    ),
                    child: CustomTextField(
                      textValue:
                          "Norma contra el acoso: En nuestra plataforma, el acoso en cualquier forma, ya sea mediante mensajes directos, comentarios públicos o cualquier otra interacción, está estrictamente prohibido. Nos comprometemos a proporcionar un entorno seguro y respetuoso para todos nuestros usuarios. Cualquier comportamiento que se perciba como intimidante, amenazante o que cause malestar a otros será tratado con seriedad. Los usuarios que violen esta norma enfrentarán medidas disciplinarias que pueden incluir la suspensión temporal o permanente de la cuenta.",
                      controller: _textController,
                    ),
                  ),
                  Container(
                    width: width * .5,
                    transformAlignment: Alignment.topCenter,
                    padding: EdgeInsets.only(bottom: height * .05),
                    child: CustomButton(
                      textValue: "Enviar reporte",
                      onPressed: () {
                        _update(_textController.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
