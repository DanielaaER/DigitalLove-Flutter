// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String orientacion;
  String nombre;
  String apellidoMaterno;
  String apellidoPaterno;
  int edad;
  String ubicacion;
  String sexo;
  String telefono;
  String usuario;
  String estado;
  String correo;
  String? password;
  String? foto;
  File? profilePicture;

  User({
    this.id,
    required this.orientacion,
    required this.nombre,
    required this.apellidoMaterno,
    required this.apellidoPaterno,
    required this.edad,
    required this.ubicacion,
    required this.sexo,
    required this.telefono,
    required this.usuario,
    required this.estado,
    required this.correo,
    this.foto,
    this.profilePicture,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json["id"],
      orientacion: json["orientacionSexual"],
      nombre: json["nombre"],
      apellidoMaterno: json["apellidoMaterno"],
      apellidoPaterno: json["apellidoPaterno"],
      edad: json["edad"],
      ubicacion: json["ubicacion"],
      sexo: json["sexo"],
      telefono: json["telefono"],
      usuario: json["usuario"],
      estado: json["estado"],
      correo: json["correo"],
      password: json["password"],
      foto: (json["fotos"] != null && json["fotos"].isNotEmpty)
          ? json["fotos"][0]
          : "",
    );
  }

  Map<String, dynamic> toJson() => {
        "orientacionSexual": orientacion,
        "nombre": nombre,
        "apellidoMaterno": apellidoMaterno,
        "apellidoPaterno": apellidoPaterno,
        "edad": edad,
        "ubicacion": ubicacion,
        "sexo": sexo,
        "telefono": telefono,
        "usuario": usuario,
        "estado": estado,
        "correo": correo,
        "fotos": [
          {"foto": foto},
        ]
      };
}
