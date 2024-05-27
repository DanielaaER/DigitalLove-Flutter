import 'package:digital_love/presentation/Home/Pages/Account/Pages/age.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/city.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/gender.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/lastname.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/name.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/sex.dart';
import 'package:digital_love/presentation/Home/Pages/Settings/Pages/cookies.dart';
import 'package:digital_love/presentation/Home/Pages/Settings/Pages/email.dart';
import 'package:digital_love/presentation/Home/Pages/Settings/Pages/preferences.dart';
import 'package:digital_love/presentation/Home/Pages/Settings/Pages/privacity.dart';
import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/shared/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../config/theme/app_colors.dart';
import '../Account/widgets/setting.dart';
import 'Pages/password.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String profilePicture = "";
  bool showPicture = true;
  ScrollController _scrollController = ScrollController();

  void _loadData() {
    String picture =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt4ZHvtgQvmWfBY"
        "-awhyifwjex-_AnOZJy30wWEYm7frPNCxUc9bbb6KUDRY_R_BsyyV0&usqp=CAU";
    setState(() {
      profilePicture = picture;
    });
  }

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        showPicture = true;
      });
    }
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
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * .1),
                  child: Text(
                    "Ajustes de cuenta",
                    style:
                        TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                  ),
                ),
                // SizedBox(height: height * .02),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.backColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingWidget(
                        setting: "Correo Electronico",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmailScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Contraseña",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PasswordScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Cerrar Sesión",
                        onPressed: () async {
                          AuthService().logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * .05,
                      bottom: height * .03,
                      left: width * .1),
                  child: const Text(
                    "Privacidad",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.backColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingWidget(
                        setting: "Política sobre cookies",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CookiesScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Política de privacidad",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacityScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Preferencias de privacidad",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PreferencesPrivacityScreen(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * .05,
                      bottom: height * .03,
                      left: width * .1),
                  child: const Text(
                    "Ayuda y soporte",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.backColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingWidget(setting: "Contactanos"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ),
        ));
  }
}
