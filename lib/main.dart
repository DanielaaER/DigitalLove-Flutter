import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/NavBar.dart';
import 'package:digital_love/presentation/Home/Pages/Notifications/notificationWidget.dart';
import 'package:digital_love/presentation/Home/Pages/Notifications/notificationfloting.dart';
import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/presentation/Wifi/wifi.dart';
import 'package:digital_love/shared/models/notification_model.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:digital_love/shared/services/webSocket.dart';
import 'package:digital_love/shared/widgets/Notification.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'presentation/Home/Pages/Notifications/NotificationScreen.dart';
import 'shared/services/ApiService.dart';
import 'shared/services/AuthServices.dart';
import 'package:web_socket_channel/status.dart' as status;

Future<void> main() async {
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
  bool _webSocketInitialized = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    apiService = ApiService();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  void _initializeWebSocket() async {
    await AuthService().loadUserData();
    if (_webSocketInitialized) return;

    print("inicio socket");
    final userId = UserData().userId;
    print("id");
    print(userId);
    print("fin socket");
    if (userId != null) {
      final wsUrl =
          Uri.parse('ws://20.55.201.18:8000/ws/notifications/$userId/');
      channel = WebSocketChannel.connect(wsUrl);

      channel.stream.listen((message) {
        print("socket");
        String notification = jsonDecode(message)['message'];
        print(notification);
        showNotification(_navigatorKey.currentContext!, notification);

        print("socket");
      }, onDone: () {
        print('WebSocket connection closed');
      }, onError: (error) {
        print('WebSocket error: $error');
      });

      _webSocketInitialized = true;
    } else {
      print('Error: User ID is null');
    }
  }

  void showNotification(BuildContext context, String notification) {
    Flushbar(
      message: notification,
      duration: Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        Icons.notifications,
        size: 28.0,
        color: AppColors.primaryColor,
      ),
      mainButton: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/notifications');
        },
        child: Text(
          'Ver',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black54,
      margin: EdgeInsets.all(8.0),
      borderRadius: BorderRadius.circular(8.0),
    ).show(context);
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
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        print("auth");
        print(authService.isLoggedIn);
        if (authService.isLoggedIn && !_webSocketInitialized) {
          _initializeWebSocket();
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
      },
    );
  }
}
