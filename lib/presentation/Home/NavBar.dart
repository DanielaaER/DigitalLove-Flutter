import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/Home.dart';
import 'package:digital_love/presentation/Home/Pages/Account/account.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/chat.dart';
import 'package:digital_love/presentation/Home/Pages/Notifications/NotificationScreen.dart';
import 'package:digital_love/presentation/Home/Pages/Settings/settings.dart';
import 'package:digital_love/presentation/Register/Register.dart';
import 'package:digital_love/shared/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'widgets/CustomNavigator.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndexBottomBar = 0;
  int currentIndexSwiperNavBar = 0;
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.chat_outlined,
    Icons.perm_identity,
    Icons.settings_outlined,
  ];

  final List<Widget> _pages = [
    HomeScreen(),
    ChatScreen(),
    AccountScreen(),
    SettingsScreen()
  ];

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  Widget _buildBody() {
    return _pages[currentIndexBottomBar];
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color(0xff212121),
      systemNavigationBarColor: Color(0xff212121),
      statusBarColor:
          Colors.white, // Configurar el color de la barra de estado como blanco
    ));
    super.initState();
  }

  void onNotificationTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationsPage(
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Fondo blanco de la barra de estado
    ));
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                  height: kToolbarHeight - 1,
                  alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.transparent, width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        // onTap: () => onTap(),
                        child: const Text(
                          "DigitalLove",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onNotificationTap,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: height * 0.03,
                              // Ajusta el tamaño según sea necesario
                              color: AppColors.whiteColor,
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
        ),
        body: Stack(
          children: [
            _buildBody(),
            Positioned(
              left: width * .15,
              bottom: 20,
              child: CustomBottomNavigationBar(
                iconList: iconList,
                currentIndex: currentIndexBottomBar,
                onTap: (index) => setState(() => currentIndexBottomBar = index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
