import 'dart:io';

import 'package:digital_love/shared/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'UserData.dart';

class AuthService with ChangeNotifier {
  final UserData _userData = UserData();
  final String url = "https://gigantic-mora-jazael-3245dd16.koyeb.app/api/v1/";

  bool _autenticando = false;
  bool _isLoggedIn = true;

  bool get autenticando => _autenticando;

  bool get isLoggedIn => _isLoggedIn;

  int? get userId => _userData.userId;

  String? get userSingleName => _userData.userSingleName;

  String? get userLastame => _userData.userLastame;

  String? get userLastName2 => _userData.userLastName2;

  String? get userFullName => _userData.userFullName;

  String? get username => _userData.username;

  String? get userToken => _userData.userToken;

  String? get tipoUsuario => _userData.tipoUsuario;

  int? get edad => _userData.edad;

  String? get estado => _userData.estado;

  String? get sexo => _userData.sexo;

  String? get telefono => _userData.telefono;

  String? get ubicacion => _userData.ubicacion;

  String? get email => _userData.email;

  String? get password => _userData.password;

  File? get front_credential => _userData.front_credential;

  File? get back_credential => _userData.back_credential;

  File? get selfie => _userData.selfie;



  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  set isLoggedIn(bool valor) {
    _isLoggedIn = valor;
    notifyListeners();
  }



  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      print("empty");
      return false; // Retorna false si alguno de los campos está vacío
    }

    try {
      final response = await Dio().post(
        '${url}loginUsuario/',
        data: {
          'usuario': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print("response");
      var data = response.data;
      print(data);
      User user = User.fromJson(data["usuario"]);
      print("user");
      print(user);

      if (data['status_code'] == 200) {
        print("entro a response data");
        _userData.userId = user.id;
        _userData.userFullName =
        "${user.nombre} ${user.apellidoPaterno} ${user.apellidoPaterno}";
        _userData.username = user.usuario;
        _userData.userSingleName = user.nombre;
        _userData.userLastame = user.apellidoPaterno;

        _isLoggedIn = true;
        notifyListeners();
        print("logeo");
      } else {
        _isLoggedIn = false;
        notifyListeners();
      }

      return _isLoggedIn;
    } catch (e) {
      print('Error during login request: $e');
      return false;
    }
  }

  Future<bool> register() async {
    try {
      File front = _userData.front_credential!;
      File back = _userData.back_credential!;
      File selfie = _userData.selfie!;

      final response = await Dio().post(
        '${url}registrarUsuario/',
        data: {
          'nombre': _userData.userSingleName,
          'apellidoPaterno': _userData.userLastame,
          'apellidoMaterno': _userData.userLastName2,
          'usuario': _userData.username,
          'password': _userData.password,
          'edad': _userData.edad,
          'sexo': _userData.sexo,
          'telefono': _userData.telefono,
          'ubicacion': _userData.ubicacion,
          'correo': _userData.email,
          'tipoUsuario': _userData.tipoUsuario,
          'estado': _userData.estado,

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print("response");
      var data = response.data;
      print(data);
      if (data['status_code'] == 200) {
        print("entro a response data");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during login request: $e');
      return false;
    }
  }


  Future<bool> saveFrontCredential(File file) async {
    try {
      _userData.front_credential = file;
      return true;
    } catch (e) {
      print('Error during saving front credential: $e');
      return false;
    }
  }

  Future<bool> saveBackCredential(File file) async {
    try {
      _userData.back_credential = file;
      return true;
    } catch (e) {
      print('Error during saving back credential: $e');
      return false;
    }
  }

  Future<bool> saveSelfie(File file) async {
    try {
      _userData.selfie = file;
      return true;
    } catch (e) {
      print('Error during saving selfie: $e');
      return false;
    }
  }

  Future<bool> saveTemporal(User user) async {
    try {

      _userData.userId = user.id;
      _userData.userFullName =
      "${user.nombre} ${user.apellidoPaterno} ${user.apellidoPaterno}";
      _userData.username = user.usuario;
      _userData.userSingleName = user.nombre;
      _userData.userLastame = user.apellidoPaterno;
      _userData.userLastName2 = user.apellidoMaterno;
      _userData.tipoUsuario = user.tipoUsuario;
      _userData.edad = user.edad;
      _userData.estado = user.estado;
      _userData.sexo = user.sexo;
      _userData.telefono = user.telefono;
      _userData.ubicacion = user.ubicacion;
      _userData.email = user.correo;
      _userData.password = user.password;



      return true;


    } catch (e) {
      print('Error during login request: $e');
      return false;
    }
  }

  void checkLoginStatus() {
    _isLoggedIn = _userData.userId != null;
    notifyListeners();
  }

  void logout() {
    _userData.userId = null;
    _userData.userFullName = null;
    _userData.username = null;
    _userData.userLastame = null;
    _userData.userSingleName = null;

    _isLoggedIn = false;
    notifyListeners();
  }
}
