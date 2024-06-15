import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:digital_love/config/theme/app_colors.dart';
import 'package:digital_love/presentation/Home/NavBar.dart';
import 'package:digital_love/presentation/Login/Login.dart';
import 'package:digital_love/presentation/Wifi/wifi.dart';
import 'package:digital_love/shared/services/UserData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:janus_client/janus_client.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'config/conf.dart';
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
          Uri.parse('ws://172.210.177.30:8000/ws/notifications/$userId/');
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

  late JanusClient client;
  late WebSocketJanusTransport ws;
  late JanusSession session;
  late JanusVideoCallPlugin publishVideo;
  RTCVideoRenderer _remoteVideoRenderer = RTCVideoRenderer();
  MediaStream? remoteVideoStream;
  AlertDialog? incomingDialog;
  AlertDialog? callDialog;
  List<String> messages = [];
  bool ringing = false;

  initJanusClient() async {
    ws = WebSocketJanusTransport(url: servermap['janus_ws']);
    client = JanusClient(
        transport: ws,
        iceServers: [
          RTCIceServer(
              urls: "stun:stun.voip.eutelia.it:3478",
              username: "",
              credential: "")
        ],
        isUnifiedPlan: true);
    session = await client.createSession();
    publishVideo = await session.attach<JanusVideoCallPlugin>();
    await _remoteVideoRenderer.initialize();
    MediaStream? tempVideo = await createLocalMediaStream('remoteVideoStream');
    setState(() {
      remoteVideoStream = tempVideo;
    });
    publishVideo.data?.listen((event) async {
      setState(() {
        messages.add(event.text);
      });
    });
    publishVideo.webRTCHandle?.peerConnection?.onConnectionState =
        (connectionState) async {
      if (connectionState ==
          RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        print('connection established');
      }
    };
    publishVideo.remoteTrack?.listen((event) async {
      if (event.track != null && event.flowing == true) {
        remoteVideoStream?.addTrack(event.track!);
        _remoteVideoRenderer.srcObject = remoteVideoStream;
        // this is done only for web since web api are muted by default for local tagged mediaStream
        if (kIsWeb) {
          _remoteVideoRenderer.muted = false;
        }
      }
    });
    publishVideo.typedMessages?.listen((even) async {
      Object data = even.event.plugindata?.data;
      if (data is VideoCallIncomingCallEvent) {
        incomingDialog =
            await showIncomingCallDialog(data.result!.username!, even.jsep);
      }
      if (data is VideoCallAcceptedEvent) {
        setState(() {
          ringing = false;
        });
        await publishVideo.handleRemoteJsep(even.jsep);
      }
      if (data is VideoCallCallingEvent) {
        Navigator.of(context).pop(callDialog);
        setState(() {
          ringing = true;
        });
      }
      if (data is VideoCallUpdateEvent) {
        if (even.jsep != null) {
          if (even.jsep?.type == "answer") {
            publishVideo.handleRemoteJsep(even.jsep);
          } else {
            var answer = await publishVideo.createAnswer();
            await publishVideo.set(jsep: answer);
          }
        }
      }
    }, onError: (error) async {
      if (error is JanusError) {
        var dialog;
        dialog = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop(dialog);
                      },
                      child: Text('Okay'))
                ],
                title: Text('Whoops!'),
                content: Text(error.error),
              );
            });
      }
    });
  }

  Future<dynamic> showIncomingCallDialog(
      String caller, RTCSessionDescription? jsep) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incoming call from ${caller}'),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    await publishVideo.handleRemoteJsep(jsep);
                    var answer = await publishVideo.createAnswer();
                    await publishVideo.acceptCall(answer: answer);
                    Navigator.of(context).pop(incomingDialog);
                  },
                  child: Text('Accept')),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true)
                        .pop(incomingDialog);
                    Navigator.of(context, rootNavigator: true).pop(callDialog);
                    await publishVideo.hangup();
                  },
                  child: Text('Reject')),
            ],
          );
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
          initJanusClient();
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
