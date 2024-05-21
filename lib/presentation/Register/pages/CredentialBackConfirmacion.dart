import 'package:digital_love/presentation/Register/pages/CameraCredentialBack.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import '../../../shared/widgets/TextBold.dart';
import '../../../shared/widgets/TextSpan.dart';
import 'SelfieConfirmation.dart';

class CredentialBackConfirmationScreen extends StatefulWidget {
  const CredentialBackConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<CredentialBackConfirmationScreen> createState() =>
      _CredentialBackConfirmationScreenState();
}

class _CredentialBackConfirmationScreenState
    extends State<CredentialBackConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _CredentialBackConfirmationView(),
        ],
      ),
    );
  }
}

class _CredentialBackConfirmationView extends StatelessWidget {
  _CredentialBackConfirmationView();

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
                'assets/images/credentialBack.png',
                fit: BoxFit.cover,
                // height: MediaQuery.of(context).size.height * .3,
                width: double.infinity,
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextSpan(
                textValue:
                    "Ya casi!! Ahora preparate para tomar una fotografía "
                    "del reverso de tu identificación oficial.",
                size: text * 1.3,
                color: AppColors.backColor,
                highlightedWords: ["fotografía", "del", "reverso"],
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
                    builder: (context) => CameraCredentialBack(),
                  ));
            }),
      ),
    ]);
  }
}
