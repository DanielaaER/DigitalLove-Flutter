import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/Pages/Account/widgets/setting.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/ReportScreens/AcosoScreen.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/ReportScreens/BullyingScreen.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/ReportScreens/DiscriminacionScreen.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/ReportScreens/EstafaScreen.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/ReportScreens/IdentidadScreen.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/ReportScreens/OtrosScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../ReportScreens/LenguajeScreen.dart';

class ReportScreen extends StatefulWidget {
  final int usuarioRecibe;

  const ReportScreen({super.key, required this.usuarioRecibe});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ScrollController _scrollController = ScrollController();

  void _loadData() {
    setState(() {});
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
      setState(() {});
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
        height: height * .8,
        width: width,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(width * .1),
                child: Text(
                  "Reportar",
                  style:
                      TextStyle(fontSize: title, fontWeight: FontWeight.bold),
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
                      setting: "Acoso",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcosoScreen(
                                usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                    SettingWidget(
                      setting: "Lenguaje inapropiado",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LenguajeScreen(
                                usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                    SettingWidget(
                      setting: "Estafa o fraude",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EstafaScreen(
                                usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                    SettingWidget(
                      setting: "Bullying",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BullyingScreen(
                                usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                    SettingWidget(
                      setting: "Suplantación de identidad",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IdentidadScreen(
                                usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                    SettingWidget(
                      setting: "Racismo o discriminación",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiscriminacionScreen(
                                usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                    SettingWidget(
                      setting: "Otros",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtroScreen(usuarioRecibe: widget.usuarioRecibe),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
