import 'dart:async';
import 'package:digital_love/presentation/Home/Home.dart';
import 'package:digital_love/presentation/Home/Pages/Chat/widgets/ChatWindow.dart';
import 'package:digital_love/shared/models/chat_conversarion_model.dart';
import 'package:digital_love/shared/models/chat_model.dart';
import 'package:digital_love/shared/models/match_user_model.dart';
import 'package:digital_love/shared/models/report_model.dart';
import 'package:dio/dio.dart';

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
    List<AppNotification> notifications = await fetchNotifications();
    _notificationsController.add(notifications);
  }

  // final Dio _dio = Dio(BaseOptions(
  //     baseUrl: 'https://better-ursola-jazael-26647204.koyeb.app/api/v1/'));

  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'http://20.55.201.18:8000/api/v1/'));

  List<AppNotification> _notifications = [];

  Future<List<AppNotification>> fetchNotifications() async {
    try {
      UserData userData = UserData();
      print("notificar");
      print(userData.userId);
      final response = await _dio.get('/notificaciones/${userData.userId}');
      List<dynamic> body = response.data;
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
      final response = await _dio.post('/like/',
          data: {"envia": userData.userId, "recibe": profile.id});
      if (response.statusCode == 200) {
        return true;
      } else {
        print("false");
        return false;
        throw Exception('Failed to like profile: ${response.statusCode}');
      }
      return true;
    } catch (error) {
      print("false");
      print("false");
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
      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        print(body);
        List<MatchUsuario> usuarios =
            body.map((dynamic item) => MatchUsuario.fromJson(item)).toList();

        return usuarios;
      } else {
        throw Exception('Failed to load usuarios');
      }
    } catch (error) {
      throw Exception('Failed to load usuarios: $error');
    }
  }

  UserData userData = UserData();

  Future<bool> newPreferences(List<String> selectedLabels) async {
    try {
      print("newPreferences");
      print(userData.userFullName);
      print(userData.userId);
      print(selectedLabels);
      final response =
          await _dio.post('/actualizar_preferencias/${userData.userId}/',
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

  Future<bool> sendReport(Reporte reporte) async {
    try {
      print("reporte");
      print(userData.userFullName);
      print(userData.userId);
      print(reporte.mensaje);
      final response = await _dio.post('/enviarReporteToAdmin/',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            "mensaje": reporte.mensaje,
            "usuario_envia_id": reporte.usuarioEnviaId,
            "usuario_recibe_id": reporte.usuarioRecibeId,
          });
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
