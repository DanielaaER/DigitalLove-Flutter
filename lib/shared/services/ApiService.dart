import 'dart:async';
import 'package:digital_love/presentation/Home/Home.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/widgets/ChatWindow.dart';
import 'package:digital_love/shared/models/chat_conversarion_model.dart';
import 'package:digital_love/shared/models/chat_model.dart';
import 'package:digital_love/shared/models/match_user_model.dart';
import 'package:digital_love/shared/models/report_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_response_model.dart';
import '../models/message_model.dart';
import '../models/message_response_model.dart';
import '../models/notification_model.dart';
import '../models/profile_model.dart';
import 'UserData.dart';

class ApiService {
  final StreamController<List<AppNotification>> _notificationsController =
      StreamController<List<AppNotification>>.broadcast();

  ApiService() {
    _fetchNotificationsPeriodically();
  }

  Stream<List<AppNotification>> get notificationsStream =>
      _notificationsController.stream;

  void _fetchNotificationsPeriodically() async {
    var notifications = await fetchNotifications();

    _notificationsController.add(notifications);
  }

  // final Dio _dio = Dio(BaseOptions(
  //     baseUrl: 'https://better-ursola-jazael-26647204.koyeb.app/api/v1/'));

  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://20.55.201.18:8000/api/v1/'));

  List<AppNotification> _notifications = [];

  Future<List<AppNotification>> fetchNotifications() async {
    try {
      UserData userData = UserData();
      print("notificar");
      print(userData.userId);
      final response = await _dio.get('/notificaciones/${userData.userId}/');
      print("response");
      print(response.data);
      List<dynamic> body = response.data;
      print(body);
      List<AppNotification> notifications = body
          .map((dynamic item) => AppNotification.fromJson(item))
          .toList()
          .reversed
          .toList();
      return notifications;
    } catch (error) {
      throw Exception('Failed to load notifications: $error');
    }
  }

  Future<bool> like(Profile profile) async {
    try {
      UserData userData = UserData();
      print("match api");
      print(userData.userFullName);
      print(userData.userId);
      final response = await _dio.post('/enviarLike/',
          data: {"envia": userData.userId, "recibe": profile.id});
      print("response");
      print(response);
      if (response.data["message"] == "Like enviado correctamente") {
        print("true");
        return true;
      } else {
        print("false");
        return false;
        throw Exception('Failed to like profile: ${response.statusCode}');
      }
      return true;
    } catch (error) {
      print("error");
      print(error);
      return false;
    }
  }

  Future<bool> responseLike(int idUser, bool action) async {
    try {
      UserData userData = UserData();
      final response = await _dio.post('/responder_like/', data: {
        "envia_id": userData.userId,
        "recibe_id": idUser,
        "accion": action
      });
      if (response.statusCode == 200) {
        print('Like response sent successfully');
        print(response);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<ChatResponse> getChat() async {
    try {
      UserData userData = UserData();
      final response = await _dio.get('/chatsUsuario/${userData.userId}');
      if (response.statusCode == 200) {
        print('Chat response sent successfully');
        print(response);
        ChatResponse chatResponse = ChatResponse.fromJson(response.data);
        return chatResponse;
      } else {
        throw Exception('Failed to get chat: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to get chat: $error');
    }
  }

  Future<MessageResponse> getMessges(int idChat) async {
    try {
      final response = await _dio.get('/mensajesAnteriores/$idChat');
      if (response.statusCode == 200) {
        print('Chat response sent successfully');
        print(response);
        MessageResponse chat = MessageResponse.fromJson(response.data);
        return chat;
      } else {
        throw Exception('Failed to get chat: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to get chat: $error');
    }
  }

  Future<List<MatchUsuario>> fetchUsuarios() async {
    try {
      final response =
          await _dio.get('encontrar_usuarios/${UserData().userId}/');
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        print(body);
        print("body");
        print(body[0]["etiquetas"]);
        List<MatchUsuario> usuarios =
            body.map((dynamic item) => MatchUsuario.fromJson(item)).toList();
        return usuarios;
      } else {
        return [];
        throw Exception('Failed to load usuarios');
      }
    } catch (error) {
      return [];
      throw Exception('Failed to load usuarios: $error');
    }
  }

  UserData userData = UserData();

  Future<bool> newPreferences(var selectedLabels) async {
    try {
      print("newPreferences");
      print(userData.userFullName);
      print(userData.userId);
      print(selectedLabels);
      final response =
          await _dio.patch('/actualizar_preferencias/${userData.userId}/',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
              data: selectedLabels);
      print("response");
      print(response);
      if (response.data["message"] == "Preferencias registradas") {
        print("true");
        print("preferencias registradas");
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

  Future<bool> registerPreferences(var data) async {
    try {
      print("registerPreferences");
      print(userData.userFullName);
      print(userData.userId);
      print(data);
      final response =
          await _dio.post('/registrar_preferencias/${userData.userId}/',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
              data: data);
      print("response");
      print(response);
      if (response.data["message"] == "Preferencias registradas") {
        print("true");
        print("preferencias registradas");
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

  Future<bool> sendReport(Reporte reporte) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('userToken');
      print("token");
      print(token);
      print("reporte");
      print(reporte.motivo);
      print(reporte.mensaje);
      print(reporte.usuarioRecibeId);

      final response = await _dio.post('/reportarUsuario/',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "motivo": reporte.motivo,
            "comentario": reporte.mensaje,
            "usuario_reportado": reporte.usuarioRecibeId,
          });
      print("response");
      print(response);
      if (response.data["message"] == "Reporte registrado exitosamente") {
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
