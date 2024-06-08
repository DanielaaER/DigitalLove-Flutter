import 'package:digital_love/presentation/Home/Home.dart';
import 'package:digital_love/presentation/Login/components/LoginError.dart';
import 'package:digital_love/presentation/Register/Register.dart';
import 'package:digital_love/shared/services/AuthServices.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:digital_love/shared/widgets/TextSpanlight.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../shared/widgets/Gesture.dart';
import '../../shared/widgets/TextBold.dart';
import '../Home/NavBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Future<bool> _login(String email, String password) async {
    print("login");
    var log = await AuthService().login(email, password);
    return log;
  }

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
          _LoginView(
            isLoading: _isLoading,
            onLogin: (email, password) async {
              setState(() {
                _isLoading = true;
              });

              bool log = await _login(email, password);
              setState(() {
                _isLoading = false;
              });

              if (log) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginErrorScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  final bool isLoading;
  final Future<void> Function(String email, String password) onLogin;

  _LoginView({required this.isLoading, required this.onLogin});

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
              textValue: "Inicio de sesión",
              size: title,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomTextSpanLight(
                  textValue: "Inicia sesión con tu cuenta DigitalLove",
                  size: text * .9,
                  color: AppColors.backColor,
                  highlightedWords: ["DigitalLove"],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(width * .06, height * .04, 0, 0),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    textValue: 'Usuario',
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
                          loading: isLoading,
                          textValue: "Iniciar Sesión",
                          onPressed: () async {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            await onLogin(email, password);
                          },
                        ),
                        SizedBox(height: height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              textValue: "¿No tienes cuenta?",
                              size: text * .8,
                              color: AppColors.backColor,
                            ),
                            CustomGesture(
                              textValue: "Registrate",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                            ),
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
