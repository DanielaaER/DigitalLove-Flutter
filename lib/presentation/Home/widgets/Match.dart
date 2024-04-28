import 'dart:ffi';

import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/shared/widgets/Button.dart';
import 'package:digital_love/shared/widgets/Text.dart';
import 'package:digital_love/shared/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../Home.dart';
import 'LabelItem.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
  final Profile profile;

  MatchScreen({Key? key, required this.profile}) : super(key: key);
}

class _MatchScreenState extends State<MatchScreen> {
  bool showLabels = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var title = width * 0.09;
    var text = width * 0.05;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=1924&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.blackColor.withOpacity(1),
                      AppColors.blackColor.withOpacity(1),
                      AppColors.blackColor.withOpacity(1),
                      AppColors.blackColor.withOpacity(0.9),
                      AppColors.blackColor.withOpacity(0.8),
                      AppColors.blackColor.withOpacity(0.7),
                      AppColors.blackColor.withOpacity(0.5),
                      AppColors.blackColor.withOpacity(0.2),
                      AppColors.blackColor.withOpacity(0.0),
                      AppColors.blackColor.withOpacity(0.0),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * .03,
                      right: width * .03,
                      bottom: height * .1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                            // Este contenedor ocupa todo el espacio disponible, empujando el GridView hacia abajo
                            ),
                      ),
                      if (showLabels)
                        Container(
                          padding: EdgeInsets.only(
                              bottom: height * .005, right: width * .08),
                          child: Text(
                            widget.profile.preferences,
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: text),
                          ),
                        ),
                      if (showLabels)
                        Container(
                          alignment: Alignment.bottomRight,
                          width: width * .9,
                          padding: EdgeInsets.only(
                              bottom: height * .005, right: width * .08),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * .06,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 40,
                                crossAxisCount: 3,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemCount: 2,
                              //cambiar a count
                              itemBuilder: (BuildContext context, int index) {
                                return LabelItem(index);
                              },
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap:
                                  true, // Ajusta el tamaño del GridView a su contenido
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: width * .5,
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomTextBold(
                                              textValue: "Mari  ",
                                              size: title,
                                              color: AppColors.whiteColor),
                                          CustomText(
                                              textValue: "24,  ",
                                              size: text,
                                              color: AppColors.whiteColor),
                                          CustomText(
                                              textValue: "Picis",
                                              size: text,
                                              color: AppColors.whiteColor),
                                        ]),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * .005),
                              Row(
                                children: [
                                  Container(
                                    width: width * .5,
                                    padding: EdgeInsets.only(left: width * .03),
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: width * .09,
                                              height: width * .09,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.primaryColor,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: AppColors.whiteColor,
                                                  size: width * .06,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                left: width * .03),
                                            child: CustomText(
                                                textValue: "Orizaba",
                                                size: text,
                                                color: AppColors.whiteColor),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: width * .4,
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                print("show labels");
                                setState(() {
                                  showLabels = !showLabels;
                                });
                                print(showLabels);
                              },
                              child: Container(
                                width: width * .14,
                                height: width * .14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.loyalty_outlined,
                                    color: AppColors.whiteColor,
                                    size: width * .09,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
