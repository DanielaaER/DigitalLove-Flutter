class Reporte {
  String motivo;
  String mensaje;
  int usuarioRecibeId;

  Reporte({required this.mensaje, required this.motivo, required this.usuarioRecibeId});

  // Convertir de JSON a un objeto Mensaje
  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      mensaje: json['mensaje'],
      motivo: json['motivo'],
      usuarioRecibeId: json['usuario_reportado'],
    );
  }

  // Convertir de un objeto Mensaje a JSON
  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
      'motivo': motivo,
      'usuario_recibe_id': usuarioRecibeId,
    };
  }
}
