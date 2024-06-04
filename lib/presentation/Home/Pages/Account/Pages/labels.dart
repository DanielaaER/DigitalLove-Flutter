import 'package:digital_love/shared/services/ApiService.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/LabelDrop.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';
import 'package:digital_love/shared/widgets/TextList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../shared/services/AuthServices.dart';
import '../widgets/setting.dart';

class LabelScreen extends StatefulWidget {
  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  TextEditingController _textController = TextEditingController();
  List<String> selectedLabels = [];

  void _onLabelsSelected(List<String> labels) {
    setState(() {
      selectedLabels = labels;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _update(List<String> selectedLabels) async {
    bool response = await ApiService().newPreferences(selectedLabels);
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
                          top: height * .01, bottom: height * .02),
                      child: CustomLabelAutocomplete(
                        onSelected: _onLabelsSelected,
                      ),
                    ),
                    // Container(
                    //   width: width * .8,
                    //   transformAlignment: Alignment.topCenter,
                    //   padding: EdgeInsets.only(
                    //       top: height * .02, bottom: height * .02),
                    //   child: Wrap(
                    //     spacing: 6.0,
                    //     runSpacing: 6.0,
                    //     children: selectedLabels
                    //         .map((label) => Chip(
                    //               label: Text(label),
                    //               onDeleted: () {
                    //                 setState(() {
                    //                   selectedLabels.remove(label);
                    //                 });
                    //               },
                    //             ))
                    //         .toList(),
                    //   ),
                    // ),
                    Container(
                      width: width * .8,
                      transformAlignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                          top: height * .02, bottom: height * .08),
                      child: CustomButton(
                        textValue: "Actualizar",
                        onPressed: () async {
                          bool response = await _update(selectedLabels);
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Etiquetas actualizadas'),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error al actualizar etiquetas'),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
