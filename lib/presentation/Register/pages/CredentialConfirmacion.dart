import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';

import '../../../shared/widgets/TextBold.dart';
import '../../../shared/widgets/TextSpan.dart';
import 'CameraCredentialFront.dart';
import 'CredentialBackConfirmacion.dart';

class CredentialConfirmationScreen extends StatefulWidget {
  const CredentialConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<CredentialConfirmationScreen> createState() =>
      _CredentialConfirmationScreenState();
}

class _CredentialConfirmationScreenState
    extends State<CredentialConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _CredentialConfirmationView(),
        ],
      ),
    );
  }
}

class _CredentialConfirmationView extends StatelessWidget {
  _CredentialConfirmationView();

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
              Image.asset(
                'assets/images/credential.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * .3,
                width: double.infinity,
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextSpan(
                textValue:
                    "Genial! Captura la parte frontal de tu identificación oficial.",
                size: text * 1.3,
                color: AppColors.backColor,
                highlightedWords: ["parte", "frontal"],
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
                    builder: (context) => CameraCredentialFront(),
                  ));
            }),
      ),
    ]);
  }
}
