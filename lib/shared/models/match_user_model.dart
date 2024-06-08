import 'dart:io';

class MatchUsuario {
  final int id;
  final String nombre;
  final String apellidoPaterno;
  final String ubicacion;
  final String correo;
  final List<String> etiquetas;
  final int edad;
  final String sexo;
  final int puntuacion;
  final String foto;

  MatchUsuario({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.ubicacion,
    required this.correo,
    required this.etiquetas,
    required this.edad,
    required this.sexo,
    required this.puntuacion,
    required this.foto,
  });

  factory MatchUsuario.fromJson(Map<String, dynamic> json) {
    print(json);
    return MatchUsuario(
      id: json['id'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellidoPaterno'],
      ubicacion: json['ubicacion'],
      correo: json['correo'],
      etiquetas: json['etiquetas'] != null
          ? List<String>.from(json['etiquetas'])
          : ["Sin etiquetas"],
      edad: json['edad'],
      sexo: json['sexo'],
      puntuacion: json['puntuacion'],
      foto: (json['fotos'] != null && json['fotos'].isNotEmpty)
          ? json['fotos'][0]
          : "https://www.gravatar.com/avatar/",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'ubicacion': ubicacion,
      'correo': correo,
      'etiquetas': etiquetas,
      'edad': edad,
      'sexo': sexo,
      'puntuacion': puntuacion,
      'foto': foto,
    };
  }
}
