import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static final UserData _instance = UserData._internal();

  int? _userId;
  String? _userSingleName;
  String? _userLastame;
  String? _userLastName2;
  String? _userFullName;
  String? _username;
  String? _userToken;
  String? _tipoUsuario;
  int? _edad;
  String? _estado;
  String? _sexo;
  String? _telefono;
  String? _ubicacion;
  String? _email;
  String? _password;
  File? _front;
  File? _back;
  File? _selfie;
  bool _noProfiles = false;

  factory UserData() {
    return _instance;
  }

  UserData._internal();

  // Getters
  int? get userId => _userId;

  String? get userSingleName => _userSingleName;

  String? get userLastame => _userLastame;

  String? get userLastName2 => _userLastName2;

  String? get userFullName => _userFullName;

  String? get username => _username;

  String? get userToken => _userToken;

  String? get tipoUsuario => _tipoUsuario;

  int? get edad => _edad;

  String? get estado => _estado;

  String? get sexo => _sexo;

  String? get telefono => _telefono;

  String? get ubicacion => _ubicacion;

  String? get email => _email;

  String? get password => _password;

  File? get front_credential => _front;

  File? get back_credential => _back;

  File? get selfie => _selfie;

  bool? get noProfiles => _noProfiles;

  // Setters
  set userId(int? value) {
    _userId = value;
  }

  set userSingleName(String? value) {
    _userSingleName = value;
  }

  set userLastame(String? value) {
    _userLastame = value;
  }

  set userLastName2(String? value) {
    _userLastName2 = value;
  }

  set userFullName(String? value) {
    _userFullName = value;
  }

  set username(String? value) {
    _username = value;
  }

  set userToken(String? value) {
    _userToken = value;
  }

  set tipoUsuario(String? value) {
    _tipoUsuario = value;
  }

  set edad(int? value) {
    _edad = value;
  }

  set estado(String? value) {
    _estado = value;
  }

  set sexo(String? value) {
    _sexo = value;
  }

  set telefono(String? value) {
    _telefono = value;
  }

  set ubicacion(String? value) {
    _ubicacion = value;
  }

  set email(String? value) {
    _email = value;
  }

  set password(String? value) {
    _password = value;
  }

  set front_credential(File? value) {
    _front = value;
  }

  set back_credential(File? value) {
    _back = value;
  }

  set selfie(File? value) {
    _selfie = value;
  }

  set noProfiles(bool? value) {
    _noProfiles = value!;
  }
}
