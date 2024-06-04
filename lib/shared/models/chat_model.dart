import 'package:flutter/foundation.dart';

class Chat {
  final int id;
  final UsuarioChat usuario;
  final UsuarioChat usuarioMatch;
  final DateTime fechaRegistro;

  Chat({
    required this.id,
    required this.usuario,
    required this.usuarioMatch,
    required this.fechaRegistro,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      usuario: UsuarioChat.fromJson(json['usuario']),
      usuarioMatch: UsuarioChat.fromJson(json['usuario_match']),
      fechaRegistro: DateTime.parse(json['fechaRegistro']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario': usuario,
      'usuario_match': usuarioMatch,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }
}

class UsuarioChat {
  final int id;
  final String nombre;
  final int edad;
  final List<dynamic> fotos;

  UsuarioChat({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.fotos,
  });

  factory UsuarioChat.fromJson(Map<String, dynamic> json) {
    return UsuarioChat(
      id: json['id'],
      nombre: json['nombre'],
      edad: json['edad'],
      fotos: List<dynamic>.from(json['fotos']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'edad': edad,
      'fotos': fotos,
    };
  }
}
