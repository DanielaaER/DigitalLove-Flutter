import 'dart:async';
import 'package:digital_love/presentation/Home/Home.dart';
import 'package:digital_love/shared/models/user_update_model.dart';
import 'package:dio/dio.dart';

import '../models/notification_model.dart';
import '../models/profile_model.dart';
import 'UserData.dart';

class ApiService {
  final StreamController<List<AppNotification>> _notificationsController =
      StreamController<List<AppNotification>>.broadcast();

  UserData userData = UserData();

  ApiService() {
    _fetchNotificationsPeriodically();
  }

  Stream<List<AppNotification>> get notificationsStream =>
      _notificationsController.stream;

  void _fetchNotificationsPeriodically() async {
    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Intervalo de 5 segundos
      List<AppNotification> notifications = await fetchNotifications();
      _notificationsController.add(notifications);
    }
  }

  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://better-ursola-jazael-26647204.koyeb.app/api/v1/'));

  Future<List<AppNotification>> fetchNotifications() async {
    try {
      UserData userData = UserData();
      print("notificar");
      print(userData.userFullName);
      print(userData.userId);
      final response = await _dio.get('/notificaciones/${userData.userId}');
      List<dynamic> body = response.data;
      List<AppNotification> notifications =
          body.map((dynamic item) => AppNotification.fromJson(item)).toList();
      return notifications;
    } catch (error) {
      throw Exception('Failed to load notifications: $error');
    }
  }

  Future<bool> like(Profile profile) async {
    try {
      print("match api");
      print(userData.userFullName);
      print(userData.userId);
      final response = await _dio.post('/like/',
          data: {"envia": userData.userId, "recibe": profile.id});
      if (response.statusCode == 200) {
        return true;
      } else {
        print("false");
        return false;
      }
    } catch (error) {
      print("false");
      print("false");
      return false;
    }
  }

  Future<bool> newPreferences(List<String> selectedLabels) async {
    try {
      print("newPreferences");
      print(userData.userFullName);
      print(userData.userId);
      print(selectedLabels);
      final response =
          await _dio.post('/registrar_preferencias/${userData.userId}/',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
              data: {"etiquetas": selectedLabels});
      print("response");
      print(response);
      if (response.data["message"] == "Preferencias registradas") {
        return true;
      } else {
        print("false");
        return false;
      }
    } catch (error) {
      print("error");
      print(error);
      return false;
    }
  }

  void dispose() {
    _notificationsController.close();
  }
}
