import 'package:connectivity/connectivity.dart';
import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/presentation/Wifi/wifi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router/routes.dart';
import 'config/theme/app_colors.dart';

void main() {
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<AuthService>(
    //       create: (_) => AuthService(),
    //     ),
    //   ],
    // child:
    MainApp(),
    // ),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  bool _hasInternet = false;
  bool _isLoading = true;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternet = connectivityResult != ConnectivityResult.none;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("wifi");
    print(_hasInternet);
    return MaterialApp(
      title: 'Digital Love',
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: AppRouter.generateRoute,
      // initialRoute: _hasInternet ? AppRouter.login : AppRouter(),
      home: _hasInternet ? LoginScreen() : WifiScreen(),
    );
  }
}
