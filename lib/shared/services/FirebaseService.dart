
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    final fCMtoken = await _firebaseMessaging.getToken();
    print("FCM token: ");
    print(fCMtoken);
  }
}