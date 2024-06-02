// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String tipoUsuario;
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

  User({
    this.id,
    required this.tipoUsuario,
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
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      tipoUsuario: "USUARIO",
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
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "tipoUsuario": "USUARIO",
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
      };
}
