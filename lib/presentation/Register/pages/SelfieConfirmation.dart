import 'package:digital_love/presentation/Register/pages/CameraSelfie.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import '../../../shared/widgets/TextBold.dart';
import '../../../shared/widgets/TextSpan.dart';
import 'PhotoError.dart';

class SelfieConfirmationScreen extends StatefulWidget {
  const SelfieConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<SelfieConfirmationScreen> createState() =>
      _SelfieConfirmationScreenState();
}

class _SelfieConfirmationScreenState extends State<SelfieConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _SelfieConfirmationView(),
        ],
      ),
    );
  }
}

class _SelfieConfirmationView extends StatelessWidget {
  _SelfieConfirmationView();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
          alignment: Alignment.topCenter,
          // height: height * .9,
          // margin:
          // EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
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
                  'assets/images/selfie.png',
                  fit: BoxFit.cover,
                  // height: MediaQuery.of(context).size.height * .3,
                  // width: MediaQuery.of(context).size.height * .3,
                  alignment: Alignment.topCenter,
                  // width: double.infinity,
                ),
              ),
              SizedBox(
                height: height * .06,
              ),
              CustomTextSpan(
                textValue:
                    "Selfie Time! Ahora preparate para tomarte una Selfie",
                size: text,
                color: AppColors.backColor,
                highlightedWords: ["tomarte", "una", "Selfie"],
              ),
              SizedBox(
                height: height * .03,
              ),
              CustomText(
                  textValue: "Recomendaciones:",
                  size: text,
                  color: AppColors.shadeColor),
              SizedBox(
                height: height * .03,
              ),
              CustomText(
                  textValue: "- Retira accesorios del rostro.",
                  size: text,
                  color: AppColors.shadeColor),
              CustomText(
                  textValue: "- Tomarla desde un buen ángulo.",
                  size: text,
                  color: AppColors.shadeColor),
              CustomText(
                  textValue: "- Limpiar el lente de la cámara",
                  size: text,
                  color: AppColors.shadeColor),
              CustomText(
                  textValue: "- vitar el desenfoque.",
                  size: text,
                  color: AppColors.shadeColor)
            ],
          )),
      Positioned(
        bottom: 65,
        child: CustomButton(
            textValue: "Siguiente",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraSelfie(),
                  ));
            }),
      ),
    ]);
  }
}
