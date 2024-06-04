import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/SexDrop.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';
import 'package:digital_love/shared/widgets/TextList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../shared/models/user_update_model.dart';
import '../../../../../shared/services/AuthServices.dart';
import '../widgets/setting.dart';

class SexScreen extends StatefulWidget {
  @override
  _SexScreenState createState() => _SexScreenState();
}

class _SexScreenState extends State<SexScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  //void _update(String update) {}
  Future<bool> _update(String update) async {
    print(update);
    UserUpdate userUpdate = UserUpdate(sexo: update);
    var response = await AuthService().updateUser(userUpdate);
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
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: title,
                      ))),
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
                      child: CustomSexAutocomplete(
                        onSelected: (value) {
                          _textController.text = value;
                        },
                      ),
                    ),
                    Container(
                      width: width * .5,
                      transformAlignment: Alignment.topCenter,
                      padding: EdgeInsets.only(bottom: height * .05),
                      child: CustomButton(
                        textValue: "Actualizar",
                        onPressed: () async {
                          bool response = await _update(_textController.text);
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Sexo actualizado'),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error al actualizar sexo'),
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