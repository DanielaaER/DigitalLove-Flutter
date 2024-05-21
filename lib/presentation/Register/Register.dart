import 'package:digital_love/presentation/Login/components/LoginError.dart';
import 'package:digital_love/presentation/Register/pages/RegisterConfirmacion.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../shared/widgets/Gesture.dart';
import '../../shared/widgets/TextBold.dart';
import '../../shared/widgets/TextFieldPasswordVerify.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  _RegisterView();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordverifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
        padding: EdgeInsets.all(width * .1),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: CustomText(
                textValue: "Registro",
                size: title,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Nombre',
              controller: _emailController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Primer apellido',
              controller: _emailController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Segundo Apellido',
              controller: _emailController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextFieldEmail(
              textValue: 'Email',
              controller: _emailController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextFieldPasswordVerify(
              textValue: 'Contraseña',
              controller: _passwordController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextFieldPassword(
              textValue: 'Contraseña',
              controller: _passwordverifyController,
            ),
            if (_passwordController.text == _passwordverifyController.text)
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .006,
                    left: width * .05),
                child: CustomText(
                    textValue: "Las contraseñas no coinciden",
                    size: text * .7,
                    color: AppColors.primaryColor),
              ),
            SizedBox(
              height: height * .02,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * .02, 0, 0),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  CustomButton(
                    textValue: "Siguiente",
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterConfirmationScreen(),
                          ));
                    },
                  ),
                  SizedBox(height: height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          textValue: "¿Ya tienes una cuenta?",
                          size: text * .8,
                          color: AppColors.backColor),
                      CustomGesture(
                        textValue: "Inicia Sesion",
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      )
                    ],
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
