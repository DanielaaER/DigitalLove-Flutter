import 'package:digital_love/shared/services/AuthServices.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldDisable.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../shared/models/user_update_model.dart';
import '../widgets/setting.dart';

class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      child: CustomTextFieldDisable(
                          titleValue: "Nombre",
                          textValue: "${AuthService().userSingleName.toString().toUpperCase()}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}