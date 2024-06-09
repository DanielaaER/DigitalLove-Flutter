import 'dart:io';

import 'package:digital_love/shared/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_update_model.dart';
import 'UserData.dart';
import 'package:http_parser/http_parser.dart';

class AuthService with ChangeNotifier {
  final UserData _userData = UserData();

  // final String url = "https://better-ursola-jazael-26647204.koyeb.app/api/v1/";

  bool _autenticando = false;
  bool _isLoggedIn = true;
  bool _noProfiles = false;

  bool get noProfiles => _noProfiles;

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

  UserData userData = UserData();

  // final Dio _dio = Dio(BaseOptions(
  //     baseUrl: 'https://better-ursola-jazael-26647204.koyeb.app/api/v1/'));
  //
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://20.55.201.18:8000/api/v1/'));

  set noProfiles(bool valor) {
    _noProfiles = valor;
    notifyListeners();
  }

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
      final response = await _dio.post(
        'loginUsuario/',
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
      print("data");
      User user = User.fromJson(data["usuario"]);
      print("user");
      print(user);

      if (data['status_code'] == 200) {
        print("entro a response data");
        _userData.userId = user.id;
        _userData.userFullName =
            "${user.nombre} ${user.apellidoPaterno} ${user.apellidoMaterno}";
        _userData.username = user.usuario;
        _userData.userSingleName = user.nombre;
        _userData.userLastame = user.apellidoPaterno;
        _userData.userLastName2 = user.apellidoMaterno;
        _userData.tipoUsuario = user.orientacion;
        _userData.edad = user.edad;
        _userData.estado = user.estado;
        _userData.sexo = user.sexo;
        _userData.telefono = user.telefono;
        _userData.ubicacion = user.ubicacion;
        _userData.email = user.correo;
        _userData.userToken = data["token"];
        print(_userData.userToken);
        print(_userData.userFullName);

        _isLoggedIn = true;
        print("foto");
        print("fot");
        print(user.foto);
        notifyListeners();
        print("logeo");
        _saveUserData();
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
    print(_userData.front_credential!.path);
    File front;
    File back;
    File selfie;
    print("selfie");
    print(_userData.selfie);
    if (_userData.front_credential != null) {
      print("front");
      print(_userData.front_credential!.path);
      front = _userData.front_credential!;
    } else {
      front = File("");
    }
    if (_userData.back_credential != null) {
      print("back");
      print(_userData.back_credential!.path);
      File back = _userData.back_credential!;
    } else {
      back = File("");
    }
    if (_userData.selfie != null) {
      print("selfie");
      print(_userData.selfie!.path);
      selfie = _userData.selfie!;
    } else {
      selfie = File("");
    }

    var response = await validateFaces(selfie, front);
    print("response");
    print(response);
    try {
      if (response) {
        File front = _userData.front_credential!;
        File back = _userData.back_credential!;
        File selfie = _userData.selfie!;

        FormData formData = FormData.fromMap(
          {
            'edad': _userData.edad,
            'estado': _userData.estado,
            'sexo': _userData.sexo,
            'nombre': _userData.userSingleName,
            'usuario': _userData.username,
            'apellidoMaterno': _userData.userLastName2,
            'apellidoPaterno': _userData.userLastame,
            'telefono': _userData.telefono,
            'correo': _userData.email,
            'orientacionSexual': _userData.orientacionSexual,
            'password': _userData.password,
            'ubicacion': _userData.ubicacion,
            'fotos': [
              {
                'foto': await MultipartFile.fromFile(
                  _userData.profilePicture!.path,
                  filename:
                      "profile.${_userData.profilePicture!.path.split('.').last}",
                  contentType: MediaType(
                    'image',
                    'jpeg',
                  ),
                ),
              }
            ],
          },
        );

        final response = await _dio.post(
          'registrarUsuario/',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );
        print("response register");
        print(response);
        _userData.userId = response.data['usuario']['id'];

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Usuario registrado correctamente');
          var newResponse = await uploadSelfie();
          print(newResponse);
          if (newResponse) {
            _isLoggedIn = true;
            notifyListeners();
            print("logeo");
            uploadProfile(_userData.profilePicture!);

            _saveUserData();
            return true;
          } else {
            return false;
          }
        } else {
          print('Error al registrar el usuario: ${response.statusCode}');
          print('Mensaje de error: ${response.data}');
          return false;
        }
      } else
        return false;
    } catch (e) {
      if (e is DioError) {
        // Manejo específico de errores Dio
        print('Error de Dio: ${e.response?.statusCode}');
        print('Datos de error: ${e.response?.data}');
        return false;
      } else {
        // Manejo de otros errores
        print('Error: $e');
        return false;
      }
    }
  }

  Future<bool> uploadProfile(File profilePicture) async {
    var data = {
      'file': await MultipartFile.fromFile(
        profilePicture.path,
        filename: "profilePicture.jpg",
        contentType: MediaType(
          'image',
          'jpeg',
        ),
      ),
    };
    final formD = FormData.fromMap(data);

    print("formD");
    print(formD);

    final response = await _dio.post(
      'usuario/agregar_foto/${_userData.userId}/',
      data: formD,
    );

    print("response");
    print(response);
    if (response.data["message"] == "Foto registrada") {
      return true;
    }
    return false;
  }

  Future<bool> uploadSelfie() async {
    if (_userData.userId == null || _userData.selfie == null) return false;

    try {
      String userId = _userData.userId.toString();
      File selfie = _userData.selfie!;

      var data = {
        'file': await MultipartFile.fromFile(
          selfie.path,
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ),
      };
      final formData = FormData.fromMap(data);
      final response = await _dio.post(
        'extraerAtributos/$userId/',
        data: formData,
      );

      print("response");
      var dat = response.data;
      print(dat);
      if (dat['CaraOvalada'] == true || dat['CaraOvalada'] == false) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during upload selfie request: $e');
      return false;
    }
  }

  Future<bool> validateFaces(File faceImage, File idImage) async {
    try {
      if (!await faceImage.exists() || !await idImage.exists()) {
        print("Uno o ambos archivos no existen.");
        return false;
      }

      var data = {
        'imagenRostro': await MultipartFile.fromFile(
          faceImage.path,
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ),
        'imagenIdentificacion': await MultipartFile.fromFile(
          idImage.path,
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ),
      };

      final formData = FormData.fromMap(data);

      final response = await _dio.post(
        'validarRostros',
        data: formData,
      );

      print("response");
      var dat = response.data;
      print(dat);

      return dat['is_valid'];
    } catch (e) {
      print('Error during validate faces request: $e');
      return false;
    }
  }

  Future<bool> saveFrontCredential(File file) async {
    try {
      print("file");
      print(file.path);
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
          "${user.nombre} ${user.apellidoPaterno} ${user.apellidoMaterno}";
      _userData.username = user.usuario;
      _userData.userSingleName = user.nombre;
      _userData.userLastame = user.apellidoPaterno;
      _userData.userLastName2 = user.apellidoMaterno;
      _userData.tipoUsuario = user.orientacion;
      _userData.edad = user.edad;
      _userData.estado = user.estado;
      _userData.sexo = user.sexo;
      _userData.telefono = user.telefono;
      _userData.ubicacion = user.ubicacion;
      _userData.email = user.correo;
      _userData.password = user.password;
      _userData.profilePicture = user.profilePicture;
      print(user.profilePicture);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('noProfiles', false);
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

  void logout() async {
    _userData.userId = null;
    _userData.userFullName = null;
    _userData.username = null;
    _userData.userSingleName = null;
    _userData.userLastame = null;
    _userData.userLastName2 = null;
    _userData.tipoUsuario = null;
    _userData.edad = null;
    _userData.estado = null;
    _userData.sexo = null;
    _userData.telefono = null;
    _userData.ubicacion = null;
    _userData.email = null;
    _userData.userToken = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _isLoggedIn = false;

    await prefs.setBool('log', false);

    notifyListeners();
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', _userData.userId!);
    await prefs.setString('userFullName', _userData.userFullName!);
    await prefs.setString('username', _userData.username!);
    await prefs.setString('userSingleName', _userData.userSingleName!);
    await prefs.setString('userLastame', _userData.userLastame!);
    await prefs.setString('userLastName2', _userData.userLastName2!);
    await prefs.setString('tipoUsuario', _userData.tipoUsuario!);
    await prefs.setInt('edad', _userData.edad!);
    await prefs.setString('estado', _userData.estado!);
    await prefs.setString('sexo', _userData.sexo!);
    await prefs.setString('telefono', _userData.telefono!);
    await prefs.setString('ubicacion', _userData.ubicacion!);
    await prefs.setString('email', _userData.email!);
    await prefs.setString('userToken', _userData.userToken!);

    await prefs.setBool('log', _isLoggedIn!);
  }

  Future<bool> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('log') ?? false;
    if (!_isLoggedIn) return false;

    _userData.userId = prefs.getInt('userId');
    _userData.userFullName = prefs.getString('userFullName');
    _userData.username = prefs.getString('username');
    _userData.userSingleName = prefs.getString('userSingleName');
    _userData.userLastame = prefs.getString('userLastame');
    _userData.userLastName2 = prefs.getString('userLastName2');
    _userData.tipoUsuario = prefs.getString('tipoUsuario');
    _userData.edad = prefs.getInt('edad');
    _userData.estado = prefs.getString('estado');
    _userData.sexo = prefs.getString('sexo');
    _userData.telefono = prefs.getString('telefono');
    _userData.ubicacion = prefs.getString('ubicacion');
    _userData.email = prefs.getString('email');
    _userData.userToken = prefs.getString('userToken');
    _userData.noProfiles = prefs.getBool('noProfiles');

    notifyListeners();

    return _isLoggedIn;
  }

  Future<bool> updateUser(UserUpdate userUpdate) async {
    try {
      final response = await _dio.patch(
        'actualizarUsuario/${userData.userId}/',
        data: userUpdate.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        print(data);
        if (data['message'] == "Usuario actualizado") {
          userData.userSingleName =
              userUpdate.nombre ?? userData.userSingleName;
          userData.userLastame =
              userUpdate.apellidoPaterno ?? userData.userLastame;
          userData.userLastName2 =
              userUpdate.apellidoMaterno ?? userData.userLastName2;
          userData.edad = userUpdate.edad ?? userData.edad;
          userData.ubicacion = userUpdate.ubicacion ?? userData.ubicacion;
          userData.sexo = userUpdate.sexo ?? userData.sexo;
          userData.telefono = userUpdate.telefono ?? userData.telefono;
          userData.estado = userUpdate.estado ?? userData.estado;
          userData.email = userUpdate.correo ?? userData.email;
          userData.password = userUpdate.password ?? userData.password;

          notifyListeners();
          return true;
        }
      }

      return false;
    } catch (e) {
      print('Error during update request: $e');
      return false;
    }
  }
}
