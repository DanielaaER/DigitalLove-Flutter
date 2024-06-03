import 'package:flutter/foundation.dart';

class Chat {
  final int id;
  final int usuario;
  final int usuarioMatch;
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
      usuario: json['usuario'],
      usuarioMatch: json['usuario_match'],
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
