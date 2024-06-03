class MatchUsuario {
  final int id;
  final String nombre;
  final String apellidoPaterno;
  final String ubicacion;
  final String correo;
  final List<String> fotos;
  final int edad;
  final String sexo;
  final int puntuacion;

  MatchUsuario({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.ubicacion,
    required this.correo,
    required this.fotos,
    required this.edad,
    required this.sexo,
    required this.puntuacion,
  });

  factory MatchUsuario.fromJson(Map<String, dynamic> json) {
    return MatchUsuario(
      id: json['id'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellidoPaterno'],
      ubicacion: json['ubicacion'],
      correo: json['correo'],
      fotos: List<String>.from(json['fotos']),
      edad: json['edad'],
      sexo: json['sexo'],
      puntuacion: json['puntuacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'ubicacion': ubicacion,
      'correo': correo,
      'fotos': fotos,
      'edad': edad,
      'sexo': sexo,
      'puntuacion': puntuacion,
    };
  }
}
