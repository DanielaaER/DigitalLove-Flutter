import 'package:digital_love/presentation/Login/Login.dart';
import 'package:flutter/material.dart';

import '../../presentation/NotFound/NotFoundPage.dart';
import '../../shared/services/AuthServices.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String search = '/search';
  static const String home = '/home';
  static const String upload = '/upload';
  static const String pdf = '/pdf';
  static const String txt = '/txt';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    AuthService().checkLoginStatus();

    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        if (AuthService().isLoggedIn) {
          print("logeooo");
          switch (settings.name) {
            default:
              return MaterialPageRoute(builder: (_) => NotFoundPage());
          }
        } else {
          print("no logeoo");

          return MaterialPageRoute(builder: (_) => LoginScreen());
        }
    }
  }
}
