import 'package:digital_love/presentation/Home/Pages/Account/Pages/age.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/city.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/gender.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/lastname.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/name.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/sex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../config/theme/app_colors.dart';
import 'widgets/setting.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
          // child: NotificationListener<ScrollNotification>(
          //   onNotification: (ScrollNotification scrollInfo) {
          //     if (scrollInfo.metrics.axis == Axis.vertical) {
          //       final double offset = scrollInfo.metrics.pixels;
          //       final bool isVisible = offset < height - (title * 6);
          //       showPicture = offset ==
          //           0; // Mostrar imagen cuando el offset es cero (final del scroll hacia arriba)
          //     }
          //
          //     return true;
          //   },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * .1),
                  child: Text(
                    "Perfil",
                    style:
                        TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                  ),
                ),
                if (showPicture)
                  Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: profilePicture.isEmpty ? 0.0 : 1.0,
                      child: CircleAvatar(
                        radius: title * 3,
                        backgroundImage: profilePicture.isNotEmpty
                            ? NetworkImage(profilePicture)
                            : null,
                        backgroundColor: Colors.grey,
                        child: profilePicture.isEmpty
                            ? Icon(
                                Icons.person,
                                size: title * 3,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                SizedBox(height: height * .05),
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
                        setting: "Nombre",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NameScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Apellido",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LastNameScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Edad",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgeScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Ciudad",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CityScreen(),
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
                    "Preferencias",
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
                        setting: "Sexo",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SexScreen(),
                              ));
                        },
                      ),
                      SettingWidget(
                        setting: "Genero",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenderScreen(),
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
                    "Intereses",
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
                      SettingWidget(setting: "Etiquetas"),
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
