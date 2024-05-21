import 'dart:async';

import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:digital_love/shared/widgets/TextSpan.dart';
import 'package:flutter/material.dart';

import 'widgets/Match.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  var profiles = [
    Profile(id: 1, preferences: 'Hetero'),
    Profile(id: 2, preferences: 'Bisexual'),
    Profile(id: 3, preferences: 'Gay'),
  ];
  bool canScroll = false;
  double _dragDistance = 0.0;
  final double _longSwipeThreshold = 100.0;
  double _pageOffset = 0.0;
  var nextProfile = 0;
  var noProfiles = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Widget nextProfileWidget;

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
                      onHorizontalDragEnd: (details) {
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
                // child: Expanded(
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
                // )
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

class Profile {
  final int id;
  final String preferences;

  Profile({required this.id, required this.preferences});
}
