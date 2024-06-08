import 'dart:async';
import 'dart:convert';

import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/Pages/Account/Pages/labels.dart';
import 'package:digital_love/presentation/Home/Pages/Welcome/welcomeScreen.dart';
import 'package:digital_love/shared/models/user_model.dart';
import 'package:digital_love/shared/services/ApiService.dart';
import 'package:digital_love/shared/services/AuthServices.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/models/profile_model.dart';
import 'widgets/Match.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  List<Profile> profiles = [];
  bool canScroll = false;
  double _dragDistance = 0.0;
  final double _longSwipeThreshold = 100.0;
  double _pageOffset = 0.0;
  var nextProfile = 0;

  // var noProfiles = false;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  late SharedPreferences pref;

  Future<void> fetchProfiles() async {
    print("no profiles");
    print(UserData().noProfiles);
    UserData().noProfiles = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getBool('noProfiles');
    setState(() {
      pref = prefs;
    });

    try {
      try {
        var users = await ApiService().fetchUsuarios();
        print("users");
        List<Profile> perfiles = [];

        users.forEach((usuario) {
          try {
            print(
                'Usuario: ${usuario.nombre}, ID: ${usuario.id}, Foto: ${usuario.etiquetas}, Edad: ${usuario.edad}');

            perfiles.add(
              Profile(
                  id: usuario.id,
                  preferences: usuario.sexo,
                  name: usuario.nombre,
                  city: usuario.ubicacion,
                  age: usuario.edad.toString(),
                  labels: usuario.etiquetas != null
                      ? usuario.etiquetas
                      : ["Sin etiquetas"],
                  photoUrl: (usuario.foto != null) ? usuario.foto : null,
                  puntuacion: usuario.puntuacion.toString()),
            ); // Manejar si fotos está vacío
          } catch (e) {
            print("Error procesando usuario: ${usuario.id}");
            print(e);
          }
        });

        print("profiles");

        setState(() {
          profiles = perfiles;
          isLoading = false;
        });
      } catch (e) {
        print("error");
        print(e);
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Future<bool> like(Profile profile) async {
    print("name");
    print(profile.name);
    var result = await ApiService().like(profile);
    print("result");
    print(result);
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ocurrió un error al dar like"),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Widget nextProfileWidget;

    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (hasError) {
      return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: WelcomeScreen(),
      );
    }

    var title = width * 0.09;
    var text = width * 0.05;
    print("NEX PROFILE");
    print(nextProfile);
    print("profiles lencht");
    print(profiles.length);
    if (nextProfile < profiles.length) {
      print("page offset");
      print("hay otro");
      print(nextProfile);
      nextProfileWidget = MatchScreen(profile: profiles[nextProfile]);
    } else {
      print("page offset");
      print("no hay otro");
      nextProfileWidget = Container(color: AppColors.primaryColor);

      pref.setBool('noProfiles', true);
      UserData().noProfiles = true;
      print("show no profiles");
      setState(() {
        canScroll = false;
        print(UserData().noProfiles);
      });
      // }
    }
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Stack(children: [
          Container(
            color: AppColors.primaryColor,
            height: MediaQuery.of(context).size.height * .79,
            width: width,
            child: nextProfileWidget,
          ),
          ListView(
            physics: canScroll
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                width: width,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  physics: canScroll
                      ? AlwaysScrollableScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      canScroll = false;
                    });
                  },
                  children: profiles.map((profile) {
                    print("profiles");
                    print(profile.id);
                    return GestureDetector(
                      onHorizontalDragStart: (details) {
                        _dragDistance = 0.0; // Reset drag distance
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _dragDistance += details.primaryDelta!;
                          _pageOffset = _dragDistance / width;
                        });
                      },
                      onHorizontalDragEnd: (details) async {
                        if (_dragDistance.abs() > _longSwipeThreshold) {
                          if (_dragDistance > 0) {
                            setState(() {
                              print("position");
                              print(profiles.indexOf(profile));
                              nextProfile = profiles.indexOf(profile) + 1;
                              print("next profile");
                              print(nextProfile);
                            });
                            print("Deslizamiento hacia la derecha detectado");
                            print("no match");

                            _resetPageOffset();
                          } else {
                            await like(profile);
                            setState(() {
                              print("position");
                              print(profiles.indexOf(profile));
                              nextProfile = profiles.indexOf(profile) + 1;
                              print("next profile");
                              print(nextProfile);
                            });

                            print("Deslizamiento hacia la izquierda detectado");
                            print(" match");

                            _resetPageOffset();
                          }

                          _resetPageOffset();
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.ease);
                          setState(() {
                            canScroll = true;
                          });
                        } else {
                          print("Tap detectado");
                          _resetPageOffset();
                        }
                        _dragDistance = 0.0;
                      },
                      child: Transform.translate(
                        offset: Offset(_pageOffset * width, 0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (profiles.length <=
                                profiles.indexOf(profile) + 1)
                              nextProfileWidget,
                            if (profiles.length >=
                                profiles.indexOf(profile) + 1)
                              Positioned.fill(
                                child: MatchScreen(profile: profile),
                              ),
                            if (profiles.length >=
                                profiles.indexOf(profile) + 1)
                              Positioned(
                                width: width,
                                bottom: height * .02,
                                left: width * _pageOffset,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print("position");
                                          print(profiles.indexOf(profile));
                                          nextProfile =
                                              profiles.indexOf(profile) + 1;
                                          print("next profile");
                                          print(nextProfile);
                                        });
                                        print("match");

                                        _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                        setState(() {
                                          canScroll = true;
                                        });
                                      },
                                      child: Container(
                                        width: width * .14,
                                        height: width * .14,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.yellowColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: AppColors.primaryColor,
                                            size: width * .09,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.1),
                                    GestureDetector(
                                      onTap: () async {
                                        await like(profile);
                                        setState(() {
                                          print("position");
                                          print(profiles.indexOf(profile));
                                          nextProfile =
                                              profiles.indexOf(profile) + 1;
                                          print("next profile");
                                          print(nextProfile);
                                        });
                                        print("match");

                                        _resetPageOffset();

                                        _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                        setState(() {
                                          canScroll = true;
                                        });
                                      },
                                      child: Container(
                                        width: width * .14,
                                        height: width * .14,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.yellowColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite_outline_outlined,
                                            color: AppColors.primaryColor,
                                            size: width * .09,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          if (UserData().noProfiles == true)
            Positioned.fill(
                child: Container(
              width: width * .8,
              color: AppColors.shadeColor.withOpacity(0.6),
              alignment: Alignment.center,
              padding:
                  EdgeInsets.fromLTRB(width * .2, height * .15, width * .2, 0),
              child: Column(
                children: [
                  Icon(
                    Icons.heart_broken_outlined,
                    size: width * .6,
                    color: AppColors.whiteColor.withOpacity(.8),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  CustomTextSpan(
                      textValue:
                          "Ooops! Parece que has superado el limite de perfiles por el dia de hoy, por favor intentalo mañana.",
                      size: text,
                      color: AppColors.whiteColor.withOpacity(.8),
                      highlightedWords: [
                        "limite",
                        "hoy",
                        "perfiles",
                        "intentalo",
                        "mañana"
                      ]),
                ],
              ),
            ))
        ]));
  }

  void _resetPageOffset() {
    setState(() {
      _pageOffset = 0.0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
