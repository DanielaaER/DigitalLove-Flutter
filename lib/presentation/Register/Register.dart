import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/presentation/Register/pages/RegisterConfirmacion.dart';
import 'package:digital_love/shared/services/AuthServices.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/SexDrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextFieldPassword.dart';
import 'package:digital_love/shared/widgets/TextField.dart';
import 'package:digital_love/shared/widgets/TextFieldEmail.dart';

import '../../shared/models/user_model.dart';
import '../../shared/widgets/Gesture.dart';
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

  Future<bool> _register(User user) async {
    var response = await AuthService().saveTemporal(user);
    print(response);
    return response;
  }

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _primerApellidoController = TextEditingController();
  TextEditingController _segundoApellidoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordverifyController = TextEditingController();
  TextEditingController _edadController = TextEditingController();
  TextEditingController _sexoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _ubicacionController = TextEditingController();
  TextEditingController _usuarioController = TextEditingController();

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
              controller: _nombreController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Primer apellido',
              controller: _primerApellidoController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Segundo Apellido',
              controller: _segundoApellidoController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Edad',
              controller: _edadController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomSexAutocomplete(onSelected: (String value) {
              _sexoController.text = value;
            }),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Telefono',
              controller: _telefonoController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Ubicacion',
              controller: _ubicacionController,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              textValue: 'Usuario',
              controller: _usuarioController,
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
                    onPressed: () async {
                      User user = User(
                        nombre: _nombreController.text.trim(),
                        apellidoPaterno: _primerApellidoController.text.trim(),
                        apellidoMaterno: _segundoApellidoController.text.trim(),
                        correo: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        edad: int.parse(_edadController.text.trim()),
                        estado: "ACTIVO",
                        sexo: _sexoController.text.trim(),
                        telefono: _telefonoController.text.trim(),
                        ubicacion: _ubicacionController.text.trim(),
                        usuario: _usuarioController.text.trim(),
                        tipoUsuario: "USUARIO",
                      );

                      var response = await _register(user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterConfirmationScreen(),
                        ),
                      );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
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
