import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  static int? userId;

  static String? userFullName;

  static String? userEmail;

  final _storage = SharedPreferences.getInstance();
  bool _autenticando = false;
  bool _isLoggedIn = true;

  bool get autenticando => _autenticando;

  bool get isLoggedIn => _isLoggedIn;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return false; // Retorna false si alguno de los campos está vacío
    }

    try {
      final response = await Dio().post(
        'http://http://127.0.0.1:5000 /login',
        data: {'email': email, 'password': password},
      );
      print(response);

      if (email == "daniela") {
        userId = 1;
        userFullName = "Daniela Espinosa";
        userEmail = "daniela@gmail.com";

        _isLoggedIn = true;
        final preferences = await _storage;
        await preferences.setBool('isLoggedIn', true);
        await preferences.setInt('userId', userId!);
        await preferences.setString('userFullName', userFullName!);
        await preferences.setString('userEmail', userEmail!);
        print("logeo");

      }else{
        _isLoggedIn = false;
      }

      return _isLoggedIn;
    } catch (e) {
      print('Error during login request: $e');
      return false;
    }
  }

  Future<void> checkLoginStatus() async {
    final preferences = await _storage;
    _isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    userId = null;
    userFullName = null;
    userEmail = null;
    _isLoggedIn = false;
    final preferences = await _storage;
    await preferences.remove('isLoggedIn');
    await preferences.remove('userId');
    await preferences.remove('userFullName');
    await preferences.remove('userEmail');
  }
}
