import 'package:digital_love/shared/models/report_model.dart';
import 'package:digital_love/shared/services/ApiService.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../../config/theme/app_colors.dart';

class AcosoScreen extends StatefulWidget {
  final int usuarioRecibe;

  const AcosoScreen({super.key, required this.usuarioRecibe});

  @override
  _AcosoScreenState createState() => _AcosoScreenState();
}

class _AcosoScreenState extends State<AcosoScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _update(String update) async {
    Reporte reporte = Reporte(
        mensaje: update,
        usuarioEnviaId: widget.usuarioRecibe,
        usuarioRecibeId: UserData().userId!);
    bool response = await ApiService().sendReport(reporte);
    print(response);
    return response;
  }

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
                      ))),
              Padding(
                padding: EdgeInsets.only(top: height * .05, left: width * .1),
                child: CustomTextBold(
                    textValue: "Reportar",
                    size: title,
                    color: AppColors.backColor),
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * .8,
                      transformAlignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                          top: height * .05, bottom: height * .05),
                      child: CustomTextField(
                          textValue: "Reportar", controller: _textController),
                    ),
                    Container(
                      width: width * .5,
                      transformAlignment: Alignment.topCenter,
                      padding: EdgeInsets.only(bottom: height * .05),
                      child: CustomButton(
                        textValue: "Reportar",
                        onPressed: () async {
                          bool response = await _update(_textController.text);
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Reporte enviado'),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error al enviar reporte'),
                            ));
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
