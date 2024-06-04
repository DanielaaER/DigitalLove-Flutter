import 'package:connectivity/connectivity.dart';
import 'package:digital_love/presentation/Home/NavBar.dart';
import 'package:digital_love/presentation/Home/Pages/Notifications/notificationfloting.dart';
import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/presentation/Wifi/wifi.dart';
import 'package:digital_love/shared/models/notification_model.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:digital_love/shared/services/webSocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'presentation/Home/Pages/Notifications/NotificationScreen.dart';
import 'shared/services/ApiService.dart';
import 'shared/services/AuthServices.dart';
import 'package:web_socket_channel/status.dart' as status;

Future<void> main() async {
  // final wsUrl = Uri.parse(
  //     'ws://better-ursola-jazael-26647204.koyeb.app/ws/notifications/${UserData().userId}/');
  // final channel = WebSocketChannel.connect(wsUrl);
  // await channel.ready;
  //
  // channel.stream.listen((message) {
  //   print("socket");
  //   channel.sink.add('received!');
  //   channel.sink.close(status.goingAway);
  //   print(message.toString());
  // });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()..loadUserData()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  bool _hasInternet = false;
  bool _isLoading = true;
  late ApiService apiService;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late WebSocketChannel channel;
  var userData = UserData();
  var userId = UserData().userId;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    apiService = ApiService();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.isLoggedIn) {
        _initializeWebSocket();
      }
      ;
    });
  }

  void _initializeWebSocket() {
    print("inicio socler");
    final userId = UserData().userId;
    if (userId != null) {
      final wsUrl = Uri.parse(
          'wss://better-ursola-jazael-26647204.koyeb.app/ws/notifications/$userId/');
      channel = WebSocketChannel.connect(wsUrl);

      channel.stream.listen((message) {
        print("socket");
        print(message.toString());
      }, onDone: () {
        print('WebSocket connection closed');
      }, onError: (error) {
        print('WebSocket error: $error');
      });
    } else {
      print('Error: User ID is null');
    }
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternet = connectivityResult != ConnectivityResult.none;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("wifi");
    print(_hasInternet);
    return Consumer<AuthService>(builder: (context, authService, child) {
      if (authService.isLoggedIn) {
        final userId = UserData().userId;
        if (userId != null) {
          _initializeWebSocket();
        }
      }

      return MaterialApp(
        title: 'Digital Love',
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        home: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _hasInternet
                ? (authService.isLoggedIn ? NavBar() : LoginScreen())
                : WifiScreen(),
        routes: {
          '/notifications': (context) => NotificationsPage(),
        },
      );
    });
  }
}
