import 'dart:async';
import 'dart:convert';

import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/services/ApiService.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:flutter/material.dart';

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
  var noProfiles = false;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    try {
      // Aquí estamos usando datos de prueba en lugar de una llamada a la API
      final response = jsonEncode([
        {
          'id': 1,
          'preferences': 'Gay',
          'name': 'Alice',
          'city': 'New York',
          'horoscop': 'Aries',
          'age': '25',
          'labels': ['Friendly', 'Outgoing', 'Traveler'],
          'photoUrl':
              'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=1924&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        },
        {
          'id': 2,
          'preferences': 'Bisexual',
          'name': 'Bob',
          'city': 'Los Angeles',
          'horoscop': 'Taurus',
          'age': '28',
          'labels': ['Music Lover', 'Foodie', 'Adventurous'],
          'photoUrl':
              'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=1924&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        },
        {
          'id': 3,
          'preferences': 'Gay',
          'name': 'Charlie',
          'city': 'San Francisco',
          'horoscop': 'Gemini',
          'age': '30',
          'labels': ['Techie', 'Gamer', 'Fitness Enthusiast'],
          'photoUrl': 'https://example.com/photos/charlie.jpg'
        }
      ]);
      final List<dynamic> profileJson = json.decode(response);
      setState(() {
        profiles = profileJson.map((json) => Profile.fromJson(json)).toList();
        isLoading = false;
      });
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
        body: Center(
          child: Text(
            'Error loading profiles. Please try again later.',
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      );
    }

    var title = width * 0.09;
    var text = width * 0.05;
    if (_pageOffset != 0 && _pageOffset.abs() < profiles.length) {
      print(profiles.length);
      print("hay otro");
      print(nextProfile);

      if (nextProfile + 1 < profiles.length) {
        int nextProfileIndex = _pageOffset > 0
            ? _pageController.page!.toInt() + 1
            : _pageController.page!.toInt();
        nextProfileWidget = MatchScreen(profile: profiles[nextProfile]);
      } else {
        nextProfileWidget = Container(color: AppColors.primaryColor);
        setState(() {
          noProfiles = true;
          canScroll = false;
          print("show no profiles");
          print(noProfiles);
        });
      }
    } else {
      print("no hay otro");
      nextProfileWidget = Container(color: AppColors.primaryColor);
      setState(() {
        canScroll = false;
      });
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
                              nextProfile = profile.id;
                              print("next profile");
                              print(nextProfile);
                            });
                            print("Deslizamiento hacia la derecha detectado");
                            print("no match");

                            _resetPageOffset();
                          } else {
                            await like(profile);
                            setState(() {
                              nextProfile = profile.id;
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
                            if (profiles.length < profile.id) nextProfileWidget,
                            if (profiles.length >= profile.id)
                              Positioned.fill(
                                child: MatchScreen(profile: profile),
                              ),
                            if (profiles.length >= profile.id)
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
          if (noProfiles == true)
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
                          "Ooops! Parece que has superado el limite de likes por el dia de hoy, por favor intentalo mañana.",
                      size: text,
                      color: AppColors.whiteColor.withOpacity(.8),
                      highlightedWords: [
                        "limite",
                        "hoy",
                        "likes",
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
