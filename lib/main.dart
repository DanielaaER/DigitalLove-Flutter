import 'package:connectivity/connectivity.dart';
import 'package:digital_love/presentation/Home/NavBar.dart';
import 'package:digital_love/presentation/Home/Pages/Notifications/notificationfloting.dart';
import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/presentation/Wifi/wifi.dart';
import 'package:digital_love/shared/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import 'config/router/routes.dart';
import 'config/theme/app_colors.dart';
import 'presentation/Home/Home.dart';
import 'presentation/Home/Pages/Notifications/NotificationScreen.dart';
import 'shared/services/ApiService.dart';
import 'shared/services/AuthServices.dart'; // Asegúrate de tener este import correcto

void main() {
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
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';
  static const String channelDescription =
      'This channel is used for important notifications.';

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    apiService = ApiService();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _startListeningForNotifications();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternet = connectivityResult != ConnectivityResult.none;
      _isLoading = false;
    });
  }

  void _startListeningForNotifications() {
    apiService.notificationsStream.listen((notifications) {
      for (var notification in notifications) {
        _showNotification(notification);
      }
    });
  }

  Future<void> _showNotification(AppNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notificación',
      notification.mensaje,
      platformChannelSpecifics,
      payload: 'item x',
    );

    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        right: 10,
        left: 10,
        child: FloatingNotificationWidget(
          message: notification.mensaje,
          onTap: () {
            ;
            _navigatorKey.currentState?.pushNamed('/notifications');
          },
        ),
      ),
    );

    overlayState?.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 5));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    print("wifi");
    print(_hasInternet);
    final authService = Provider.of<AuthService>(context);

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
        '/notifications': (context) =>
            NotificationsPage(apiServiceapiService: apiService),
      },
    );
  }
}
