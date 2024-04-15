import 'package:digital_love/shared/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../shared/widgets/Gesture.dart';
import '../../shared/widgets/TextBold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/banner.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * .3,
            width: double.infinity,
          ),
          _LoginView(),
        ],
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  _LoginView();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .3),
        padding: EdgeInsets.all(width * .1),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              textValue: "Inicio de Sesión",
              size: title,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomText(
                  textValue: "Inicia sesión con tu cuenta ",
                  size: text,
                  color: AppColors.backColor,
                ),
                CustomTextBold(
                  textValue: "DigitalLove",
                  size: text,
                  color: AppColors.primaryColor,
                ),
              ],
            ),

            // SizedBox(height: 1),
            Container(
              padding: EdgeInsets.fromLTRB(width * .06, height * .04, 0, 0),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFieldEmail(
                    textValue: 'Email',
                    controller: _emailController,
                  ),
                  SizedBox(height: height * .03),
                  CustomTextFieldPassword(
                    textValue: 'Contraseña',
                    controller: _passwordController,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, height * .07, 0, 0),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        CustomButton(
                          textValue: "Iniciar Sesión",
                          onPressed: () {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                          },
                        ),
                        SizedBox(height: height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                textValue: "¿No tienes cuenta?",
                                size: text * .8,
                                color: AppColors.backColor),
                            CustomGesture(
                              textValue: "Registrarse",
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
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
          ],
        ),
      ),
    );
  }
}
